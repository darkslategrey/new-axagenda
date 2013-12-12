# -*- coding: utf-8 -*-



class AxProxy

  @@logger = AxLogger.new.logger

  def self.get_events(params={})
    @@logger.debug "params <#{params}>"

    events = []

    today      = DateTime.current
    prev_month = params['startDay'].nil? ? today - 1.month : DateTime.parse(params['startDay'])
    next_month = params['endDay'].nil?   ? today + 3.month : DateTime.parse(params['endDay'])

    date_cond  = "datep <= '#{next_month}' and datep >= '#{prev_month}'"
    regexp_cond= '^Bon de commande|^Facture FA|^Facture AV|^Proposition valid|^Société'
    label_cond = "label not regexp '#{regexp_cond}'"

    [:jobenfance, :jobdependance].each { |doli_db| 
      event_types  = EventType.valid doli_db
      events       << event_types.map { |event_type|
        event_type.events.where("#{date_cond} and #{label_cond}").to_a
      }.compact
    }
    events.flatten!
    @@logger.debug "#{events.size} events found"
    events
  end
end



