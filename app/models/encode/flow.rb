module Encode
  class Flow < Micro::Case
    flow Encode::ValidateTask,
         Encode::ValidateAssets,
         Encode::DownloadAssets
  end
end