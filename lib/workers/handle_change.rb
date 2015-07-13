module Workers
  class HandleChange
    include Sidekiq::Worker

    sidekiq_options retry: false

    def perform(sync_log_id, person_uuid)
      begin
        trogdir_person = TrogdirPerson.new(person_uuid)
        action = SyncData.new(trogdir_person).create_or_update!
        TrogdirChangeFinishWorker.perform_async change.sync_log_id, action
      rescue StandardError => err
        TrogdirChangeErrorWorker.perform_async(sync_log_id, err.message)
        Raven.capture_exception(err) if defined? Raven
      end
    end
  end
end
