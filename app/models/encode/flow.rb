module Encode
  class Flow < Micro::Case
    flow Encode::ValidateAssets,
         Encode::DownloadAssets
  end
end