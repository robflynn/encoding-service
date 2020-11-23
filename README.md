
app/jobs/encode/transcode_rendition_job.rb:
  * [43] [TODO] Handle failure of TranscodeVideo

app/jobs/encode_job.rb:
  * [ 5] [TODO] Implement `InvalidTaskType` or handle this some other way
  * [14] [TODO] Get specifically the video or audio asset here, if we handle creation that way
  * [28] [TODO] Configurable audio bitate?

app/models/encode.rb:
  * [ 1] [TODO] I don't like calling `ensure_path` this much. Probably need to rethink the way path stuff works.

app/models/encode/download_assets.rb:
  * [14] [TODO] Implement `Encode::DownloadAssets`

app/models/encode/extract_audio.rb:
  * [15] [TODO] Make sure this path exists before you tr y o write to it...

app/models/encode/transcode_video.rb:
  * [15] [TODO] Track rendition status?

app/models/encode/validate_assets.rb:
  * [14] [TODO] Implement `Encode::ValidateAssets`

app/models/encode/validate_task.rb:
  * [16] [TODO] Implement `Encode::ValdateTask`

app/models/encoding_task.rb:
  * [54] [TODO] Implement `EncodingTask` `duration`

app/models/manifest/dash.rb:
  * [ 9] [TODO] Make `Manifest::Dash` timescale configurable?>
  * [50] [TODO] Don't hard code audio codec in `Manifest::Dash`
  * [62] [TODO] Implement multiple audio bitrate support in `Encode::Manifest`
  * [63] [TODO] Don't hard code audio bitrate`Encode::Manifest`
  * [88] [FIXME] Don't hardcode representation codec this

app/models/store.rb:
  * [39] [TODO] Implement `InvalidConfigurationError`

app/models/store/local_store.rb:
  * [29] [TODO] Implement `FileMissingError`

app/models/store/s3_store.rb:
  * [50] [TODO] Implement `FileMissingError`

