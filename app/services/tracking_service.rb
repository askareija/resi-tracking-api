# frozen_string_literal: true

class TrackingService
  def self.track(*args, &block)
    new(*args, &block).execute
  end

  def initialize(no_resi, expedition_type, user)
    @no_resi = no_resi
    @expedition_type = expedition_type
    @user = user
    @track_history = TrackHistory.new(noresi: @no_resi, expedition_type: @expedition_type, user: @user)
  end

  def execute
    uri = URI('https://jagoresi.com/cek-resi/')
    res = Net::HTTP.post_form(uri, 'resi' => @no_resi, 'cek' => '', 'jasa' => @expedition_type.delete("\n"))
    doc = Nokogiri::HTML(res.body)

    receipt = {}

    # Parsing general information
    table_info = doc.search('div .table-striped')
    if table_info.empty?
      @track_history.status = 'NOT FOUND'
      @track_history.save

      return nil
    else
      receipt[:no_resi] = table_info.first.search('tr')[0].search('td')[2].try(:text)
      receipt[:status] = table_info.first.search('tr')[1].search('td')[2].try(:text)
      receipt[:expedition_type] = table_info.first.search('tr')[2].search('td')[2].try(:text)
      receipt[:date] = table_info.first.search('tr')[3].search('td')[2].try(:text)
      receipt[:sender] = (table_info.first.search('tr')[4].search('td')[2].try(:text) rescue nil)
      receipt[:origin] = (table_info.first.search('tr')[5].search('td')[2].try(:text) rescue nil)
      receipt[:recipient] = (table_info.first.search('tr')[6].search('td')[2].try(:text) rescue nil)
      receipt[:recipient_address] = (table_info.first.search('tr')[7].search('td')[2].try(:text) rescue nil)

      receipt[:details] = []
      doc.search('table tbody').first.search('tr').each_with_index do |row, i|
        detail = {}
        detail[:date] = Time.zone.parse(row.search('td')[0].try(:text))
        detail[:city] = row.search('td')[1].try(:text)
        detail[:description] = row.search('td')[2].try(:text)

        receipt[:details] << detail
      end

      @track_history.status = receipt[:status]
      @track_history.save
      return receipt
    end
  end
end
