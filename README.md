
app/jobs/encode/transcode_rendition_job.rb:
  * [40] [TODO] Handle failure of TranscodeVideo

app/jobs/encode_job.rb:
  * [ 5] [TODO] Implement `InvalidTaskType` or handle this some other way
  * [14] [TODO] Get specifically the video or audio asset here, if we handle creation that way

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

app/models/store.rb:
  * [39] [TODO] Implement `InvalidConfigurationError`

app/models/store/s3_store.rb:
  * [50] [TODO] Implement `FileMissingError`

