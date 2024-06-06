class SynchronisationQueueJob < ApplicationJob

  sidekiq_options retry: 5

  def perform(sync_data, user_data)
    synchronise(sync_data, user_data)
  end

  def synchronise(insert_data, user_data)
    if insert_data[:create_production_transactions].length > 0
      send_on_server(insert_data[:create_production_transactions].shift, user_data, :create_production_transaction)
    elsif insert_data[:update_production_transactions].length > 0
      send_on_server(insert_data[:update_production_transactions].shift, user_data, :update_production_transaction)
    end

    if insert_data[:create_production_transactions].length > 0 or insert_data[:update_production_transactions].length > 0
      SynchronisationQueueJob.perform_later(insert_data, user_data)
    else
      # add ststus in table completed
    end
  end

  def send_on_server(element, user_data, query)
      case query
      when :create_production_transaction then
        Caspio::Client.instance.create_production_transactions(element)
      when :update_production_transaction then
        Caspio::Client.instance.update_production_transactions(element)
      else
        raise NameError
      end
      # raise StandardError
  end
end
