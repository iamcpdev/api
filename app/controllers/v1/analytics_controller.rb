# frozen_string_literal: true

module V1
  # TODO: Convert to new response format from ApiController
  class AnalyticsController < ApplicationController
    SEGMENT_WRITE_KEY = Rails.application.secrets.segment_write_key

    def identify
      segment(:identify, %w[user_id traits])
    end

    def track
      segment(:track, %w[user_id event properties])
    end

    def page
      segment(:page, %w[user_id name properties])
    end

    def group
      segment(:group, %w[user_id group_id traits])
    end

    private

    def segment(method, allowed_arguments)
      analytics = Segment::Analytics.new(write_key: SEGMENT_WRITE_KEY)

      arguments = {}
      keys = params.to_unsafe_h.keys & allowed_arguments

      keys.each { |k| arguments[k] = params.to_unsafe_h[k] }

      analytics.public_send(method, arguments)

      render json: { ok: true, method: method, arguments: arguments },
             status: 200
    rescue StandardError => e
      render json: { ok: false, error: e.message }
    end
  end
end
