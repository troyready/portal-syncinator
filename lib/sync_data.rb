class SyncData
  attr_reader :trogdir_person

  def initialize(trogdir_person)
    @trogdir_person = trogdir_person
  end

  def create_or_update!
    result = client.execute("SELECT * FROM #{Settings.data_warehouse.table} WHERE id=\'#{trogdir_person.legacy_biola_id}\'").each{|r|}
    # If the call returns any results, update
    result.count > 0 ? update : create
  end

  def create
    Log.info "Creating Portal entry for person #{trogdir_person.netid}"
    result = client.execute("INSERT INTO #{Settings.data_warehouse.table}
                            (id, name, shortname, shortname_name, shortname_number)
                            VALUES (\'#{trogdir_person.legacy_biola_id}\', \'#{trogdir_person.name}\', \'#{trogdir_person.netid}\', \'#{trogdir_person.netid_name}\', \'#{trogdir_person.netid_number}\')")
    result.do

    :create
  end

  def update
    Log.info "Update Portal entry for person #{trogdir_person.netid}"
    result = client.execute("UPDATE #{Settings.data_warehouse.table}
                            SET name=\'#{trogdir_person.name}\', shortname=\'#{trogdir_person.netid}\', shortname_name=\'#{trogdir_person.netid_name}\', shortname_number=\'#{trogdir_person.netid_number}\'
                            WHERE id=\'#{trogdir_person.legacy_biola_id}\'")
    result.do

    :update
  end

  private

  def client
    client = TinyTds::Client.new username: Settings.data_warehouse.username, password: Settings.data_warehouse.password, dataserver: Settings.data_warehouse.dataserver
  end
end
