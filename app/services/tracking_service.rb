class TrackingService
  def self.track(*args, &block)
    new(*args, &block).execute
  end

  def initialize(no_resi, expedition_type)
    @no_resi = no_resi
    @expedition_type = expedition_type
  end

  def execute
    uri = URI('https://jagoresi.com/cek-resi/')
    res = Net::HTTP.post_form(uri, 'resi' => @no_resi, 'cek' => '', 'jasa' => @expedition_type.gsub("\n",""))
    doc = Nokogiri::HTML(res.body)

    info = OpenStruct.new

    # Parsing general information
    table_info = doc.search('div .table-striped')
    unless table_info.empty?
      info.no_resi = table_info.first.search('tr')[0].search('td')[2].try(:text)
      info.status = table_info.first.search('tr')[1].search('td')[2].try(:text)
      info.expedition_type = table_info.first.search('tr')[2].search('td')[2].try(:text)
      info.date = table_info.first.search('tr')[3].search('td')[2].try(:text)
      info.sender = table_info.first.search('tr')[4].search('td')[2].try(:text)
      info.origin = table_info.first.search('tr')[5].search('td')[2].try(:text)
      info.recipient = table_info.first.search('tr')[6].search('td')[2].try(:text)
      info.recipient_address = table_info.first.search('tr')[7].search('td')[2].try(:text)

      info.details = Hash.new
      doc.search('table tbody').first.search('tr').each_with_index do |row, i|
        detail = Hash.new
        detail[:date] = Time.zone.parse(row.search('td')[0].try(:text))
        detail[:city] = row.search('td')[1].try(:text)
        detail[:description] = row.search('td')[2].try(:text)
        
        info.details[i] = detail
      end

      return info
    else
      return false
    end
  end
end