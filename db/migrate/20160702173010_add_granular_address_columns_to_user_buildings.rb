class AddGranularAddressColumnsToUserBuildings < ActiveRecord::Migration
  
  # Possible hash keys from Indirizzo address-parsing gem.
  # I bet :prenum is unit number. But I'm adding it anyway becuase it won't tangle with Unit.unit_number becuase that's going to the Unit model.
  # Also, no idea what a :sufnum is. 
  # :prenum, :number, :sufnum, :street, :city, :state, :zip, :plus4, and :country
  GRANULES = [:prenum, :number, :sufnum, :street, :city, :state, :zip, :plus4, :country]

  # Everything is a string because I don't know/not validating anything that comes through the address or Indirizzo parsing.
  # I'm not making and DB-side defaults or null settings because I don't want to.
  def up
  	GRANULES.each do |grain|
  		add_column :user_buildings, grain, :string
  	end
  end

  def down
  	GRANULES.each do |grain|
  		remove_column :user_buildings, grain, :string
  	end
  end
end
