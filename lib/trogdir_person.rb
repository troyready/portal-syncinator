class TrogdirPerson
  attr_reader :uuid

  def initialize(uuid)
    @uuid = uuid
  end

  def biola_id
    get_value_from_nested_record(:ids, :biola_id, :identifier)
  end

  def legacy_biola_id
    zero_pad = Settings.biola_id_length - biola_id.length
    "0"*zero_pad + biola_id
  end

  def netid
    get_value_from_nested_record(:ids, :netid, :identifier)
  end

  # Ex: johnd of netid johnd0
  def netid_name
    netid.gsub(/[0-9]/, "")
  end

  # Ex: 0 of netid johnd0
  def netid_number
    netid.gsub(/[a-z]/, "")
  end

  def name
    "#{last_name}, #{first_name} #{middle_name}".gsub("'", "\\\\'")
  end

  private

  def hash
    @hash ||= Trogdir::APIClient::People.new.show(uuid: uuid).perform.parse
  end

  def first_name
    hash['first_name']
  end

  def middle_name
    hash['middle_name']
  end

  def last_name
    hash['last_name']
  end

  def get_value_from_nested_record(collection, type, return_attr)
    record = Array(hash[collection.to_s]).find { |record| record['type'] == type.to_s }
    record[return_attr.to_s] unless record.nil?
  end
end
