class Upload < ActiveRecord::Base
  belongs_to :user, inverse_of: :uploads
  has_many :bills

  def self.jsonify(xml)
    Hash.from_xml(xml).to_json
  end

  def create_bills_from_xml
    doc = Nokogiri::XML(xml)
    readings = doc.xpath('//ns:IntervalReading')
    readings.each do |reading|
      start_date_in_sec = reading.at('.//ns:start').text.to_i
      duration_in_sec = reading.at('.//ns:duration').text.to_i
      cost = reading.at('.//ns:cost').text.to_f / 100000
      kwh = reading.at('.//ns:value').text.to_i
      bill_date = Time.at(start_date_in_sec + duration_in_sec)
      bill_days = duration_in_sec/86400 # seconds per day

      bill = Bill.create(
        bill_received: bill_date,
        bill_days: bill_days,
        usage: kwh,
        amount: cost,
        user: user,
        unit: user.unit,
        upload: self
        )
    end
  end
end
