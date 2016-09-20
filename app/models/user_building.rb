require 'indirizzo/address' # That's how you have to require it, apparently.
class UserBuilding < ActiveRecord::Base

  # TODO: Handle parent-child dependencies for UserBuilding, User, Unit, Bill,
  # so as not to helplessly orphan the children.
  has_many :units, dependent: :destroy # My ruthless destruction in spec was causing fking foreign key constraint errors.

  validates :address, presence: true, allow_blank: false

  after_save :parse_and_save_address_granules

  # Indirizzo-available address hash keys.
  # => :prenum, :number, :sufnum, :street, :city, :state, :zip, :plus4, and :country
  # For now I'm going to leave these as model-written attributes (ie not in the controller params)

  def self.all_addresses
    select(:address, :id).map do |ub|
      { label: ub.address, value: ub.id }
    end
  end

  def self.granularize_address(address)
    Indirizzo::Address.new(address)
  end

  # Parse and store address input into granules.
  # This is called on #after_save callback and will not trigger callbacks or validations or update timestamps
  # because that's just how #update_column rolls. None of that deep stackleveling shit.
  #
  # TODO: A way to hone these attributes as-and-if better data becomes available.
  # ie ||= on steroids.
  def parse_and_save_address_granules

    parsed = UserBuilding.granularize_address(address) # address presence is validated

    update_column(:prenum, parsed.prenum)
    update_column(:number, parsed.number)
    update_column(:sufnum, parsed.sufnum)
    update_column(:street, parsed.street[0].upcase) if parsed.street.present? # take only the first. # TODO improve via Array column or having any idea about how what goes in there
    update_column(:city, parsed.city[0].upcase) if parsed.city.present?
    update_column(:state, parsed.state[0].upcase) if parsed.state.present?
    update_column(:plus4, parsed.plus4)
    update_column(:country, parsed.country[0].upcase) if parsed.country.present?
  end

  # Look for address by upcasing input and existing row attrs.
  # I chose upcasing because it seems more formal, and I like that kind of thing.
  def self.find_by_address_upcase(address)
    where('upper(address) = ?', address.upcase).first
  end

  # No, I have no idea how exactly LIKE works or what to expect from it.
  def self.find_by_address_like(address)
    where('address LIKE ?', address).first # .first because I have no idea how to programatically tell which would be preferable given multiple records
  end

  # I hereby declare that reasonable means matching all of city, street, and number.
  # I also hereby declare that LIKE is close enough. = would be more precise.
  # I also don't know anything about what the helll LIKE actually does.
  #
  # TODO: Handle the array-ization of the granules in a way maybe using #includes or
  # something sneaky to check for close-enough identity.
  def self.find_reasonable_match_by_address_granules(granules)

    # TODO: Move trustable address components to a constant.
    if [:city, :street, :number].map{ |c| c.present? }.all?
      where('city LIKE ? AND street LIKE ? AND number LIKE ?', granules.city[0].upcase, granules.street[0].upcase, granules.number).first
    else
      nil
    end
  end

  # Look for UserBuilding with the address given by user.
  # Unless an exact match is found by address, we'll continue our quest by trying other,
  # less specific queries, and finally by matching against a reasonably-diluted granularity&trade;.
  # If there is no eventual reasonable match we'll create a new building.
  #
  # TODO: It would be pretty snazzy to use a Geocode service to get the lat and lon and
  # use that as a find_by/or-close-enough check on lat/long and/or schmaddress.
  # ie Let Google do the address decision clusterfuckery.
  def self.find_or_generate(user_building_id, address_input=nil)

    # I'm going to use #return here to try to escape this hellish
    # non-looping business lazily.

    # Awesome.
    return find(user_building_id) if user_building_id.present? # in case any squirmy ''s make their way in


    # Find by exact address match. That would be pretty awesome.
    match_by_exact_address = find_by(address: address_input)
    return match_by_exact_address if match_by_exact_address

    # Still pretty cool.
    match_by_upcasing = find_by_address_upcase(address_input)
    return match_by_upcasing if match_by_upcasing

    # Erm, getting kind of sketchy.
    match_by_like = find_by_address_like(address_input)
    return match_by_like if match_by_like

    # Sheets to the wind.
    if address_input.present?
      granularized = granularize_address(address_input)
        #from -e:1:in `<main>'irb(main):010:0> i = Indirizzo::Address.new('47 Paulina St. #1, Somerville, MA 02144', expand_streets: false)
        # => #<Indirizzo::Address:0x00556fd9739e90 @options={:expand_streets=>false}, @text="47 Paulina St 1, Somerville, MA 02144", @zip="02144", @plus4=nil, @country="", @state="MA", @full_state="ma", @number="47", @prenum=nil, @sufnum="", @street=["paulina st 1", "somerville"], @city=["somerville"]>

      match_by_granules = find_reasonable_match_by_address_granules(granularized)
      return match_by_granules if match_by_granules
    end

    new_user_building = new(address: address_input)
    new_user_building.save! if new_user_building.valid?
    return new_user_building
  end
end
