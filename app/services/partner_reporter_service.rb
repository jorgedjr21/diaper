module PartnerReporterService
  def self.partner_types_and_zipcodes(partners:)
    return [] if partners.blank?
    return [{ 'type1' => 2, 'type2' => 1 }, %w(1111 2222)] if Rails.env.development?

    total = {}
    zipcodes = []

    partners.each do |partner|
      partner_agency = DiaperPartnerClient.get(id: partner.id)
      next if partner_agency.blank?

      total[(partner_agency[:agency_type]).to_s] = 0 if total[(partner_agency[:agency_type]).to_s].blank?
      total[(partner_agency[:agency_type]).to_s] += 1
      zipcodes << partner_agency[:address][:zip_code]
    end

    [total, zipcodes.uniq]
  end
end
