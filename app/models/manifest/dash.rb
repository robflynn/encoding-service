require 'securerandom'
require 'builder'
require 'nokogiri'

module Manifest
  # TODO: Make `Manifest::Dash` segment duration configurable. This will need to apply to the chunker as well.
  SEGMENT_DURATION = 4000

  class Dash
    # TODO: Make `Manifest::Dash` timescale configurable?>
    DEFAULT_TIMESCALE = 1000

    def initialize(task:)
      @encoding = task
      @id = SecureRandom.uuid
    end

    def to_mpd
      header = Nokogiri::XML('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
      builder = Nokogiri::XML::Builder.with(header) do |xml|
        xml.MPD(
          id: @id,
          profiles: "urn:mpeg:dash:profile:isoff-main:2011",
          type: "static",
          availabilityStartTime: iso_time(Time.now),
          publishTime: iso_time(Time.now),
          mediaPresentationDuration: Duration.new(@encoding.duration).iso8601,
          minBufferTime: "P0Y0M0DT0H0M1.000S",
          "xmlns:ns2": "http://www.w3.org/1999/xlink",
          xmlns: "urn:mpeg:dash:schema:mpd:2011",
          "xmlns:cenc": "urn:mpeg:cenc:2013",
          "xmlns:mspr": "urn:microsoft:playready"
        ) {
            xml.Period(id: SecureRandom.uuid, start: "P0S") {
            }
          }
      end

      builder.to_xml
    end

    private

    def iso_time(time)
      time.strftime("%Y-%m-%dT%H:%M:%SZ")
    end

    def builder
      @builder ||= Builder::XmlMarkup.new(indent: 1)
    end
  end
end