require 'securerandom'
require 'builder'
require 'nokogiri'

module Manifest
  SEGMENT_DURATION = Encode::SegmentDuration.in_milliseconds

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
              video_adaptation_set(xml)
            }
          }
      end

      builder.to_xml
    end

    private

    def iso_time(time)
      time.strftime("%Y-%m-%dT%H:%M:%SZ")
    end

    def video_adaptation_set(xml)
      xml.AdaptationSet(mimeType: "video/mp4") {
        xml.SegmentTemplate(
          media: "../video/$RepresentationID$/dash/segment_$Number$.m4s",
          initialization: "../video/$RepresentationID$/dash/init.mp4",
          duration: SEGMENT_DURATION,
          startNumber: 0,
          timescale: DEFAULT_TIMESCALE
        )

        representations(xml)
      }
    end

    def representations(xml)
      @encoding.renditions.each do |rendition|
        xml.Representation id: "#{rendition.resolution}_#{rendition.bitrate_bps}",
                           bandwidth: rendition.bitrate_bps,
                           width: rendition.width,
                           height: rendition.height,
                           frameRate: rendition.fps,
                           codecs: "avc1.4D001E"  # FIXME: Don't hardcode representation codec this
      end
    end

    def builder
      @builder ||= Builder::XmlMarkup.new(indent: 1)
    end
  end
end