class Processor < Flowcation::Processor
  def urls(input)
    input.gsub!("url('../img/", "asset-url('")
    input.gsub!('url("../img/', 'asset-url("')
    input.gsub!("url('../fonts/", "asset-url('")
    input.gsub!('url("../fonts/', 'asset-url("')
    input
  end
end