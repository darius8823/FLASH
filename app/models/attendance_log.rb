# frozen_string_literal: true

# Attendance Log model
class AttendanceLog < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :user_id, uniqueness: { scope: [:event_id], message: "can't attend the same event twice." }
  validate :same_passcode?
  validate -> { errors.add(:event_id, 'not active.') unless event.active? }

  private

  def same_passcode?
    errors.add(:passcode, 'does not match.') unless passcode.eql? event.passcode
  end
end
