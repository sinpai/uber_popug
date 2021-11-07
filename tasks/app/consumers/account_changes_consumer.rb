# frozen_string_literal: true
require 'json'
class AccountChangesConsumer < Karafka::BaseConsumer
  def consume
    params_batch.each do |message|
      puts '-' * 80
      p message
      puts '-' * 80
      message = JSON.parse(message.raw_payload)
      data = message['data']
      case message['event_name']
      when 'AccountCreated'
        Account.create(
          public_id: data['public-id'],
          email: data['email'],
          full_name: data['full_name'],
          position: data['position']
        )
      when 'AccountUpdated'
        account = Account.find_by(public_id: data['public-id'])
        account.update_columns(
          email: data['email'],
          full_name: data['full_name'],
          position: data['position']
        ) if account.present?
      when 'AccountDeleted'
        account = Account.find_by(public_id: data['public-id'])
        account.destroy if account.present?
      when 'AccountRoleChanged'
        account = Account.find_by(public_id: data['public-id'])
        account.update_columns(position: data['position']) if account.present?
      else
        # store events in DB
      end
    end
  end
end
