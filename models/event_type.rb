# -*- coding: utf-8 -*-
module EventType 


  def find_actions_by_author(authors)
    klass = eval(self.class.name)
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    ev_conditions = "datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'"
    ev_conditions += " and fk_user_author in (#{authors.join(',')})"
    ev_conditions += " and label not regexp '^Bon de commande|^Facture FA|^Facture AV|^Proposition valid|^Société'"
    klass.logger.info("#{klass.name} find_actions_by_author: ev_conditions <#{ev_conditions}>")
    actions = [] 
    ev_types = klass.where("code not in (?, ?)", 'AC_OTH_AUTO', 'AC_REGIE')
    ev_types.each { |et|
      actions += et.events.where(ev_conditions)
    }
    actions.flatten!
    klass.logger.info("#{klass.name} find_actions_by_author: Found #{actions.size} actions")
    actions
  end

  def find_regies_by_author(authors)
    klass = eval(self.class.name)
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    ev_conditions = "datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'"
    ev_conditions += " and fk_user_author in (#{authors.join(',')})"
    klass.logger.info("#{klass.name} find_regies_by_author: ev_conditions <#{ev_conditions}>")
    actions = [] 
    ev_types = klass.where("code = 'AC_REGIE'")
    ev_types.each { |et|
      actions += et.events.where(ev_conditions)
    }
    actions.flatten!
    klass.logger.info("#{klass.name} find_regies_by_author: Found #{actions.size} actions")
    actions
  end

  def find_actions_by_todo(todos)
    klass = eval(self.class.name)
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    ev_conditions = "datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'"
    ev_conditions += " and fk_user_action in (#{todos.join(',')})"
    ev_conditions += " and label not regexp '^Bon de commande|^Facture FA|^Facture AV|^Proposition valid|^Société'"
    klass.logger.info("#{klass.name} find_actions_by_todo: ev_conditions <#{ev_conditions}>")
    actions = [] 
    ev_types = klass.where("code not in (?, ?)", 'AC_OTH_AUTO', 'AC_REGIE')
    ev_types.each { |et|
      actions += et.events.where(ev_conditions)
    }
    actions.flatten!
    klass.logger.info("#{klass.name} find_actions_by_todo: Found #{actions.size} actions")
    actions
  end

  def find_regies_by_todo(todos)
    klass = eval(self.class.name)
    date = DateTime.current
    prev_month = date - 1.month
    next_month = date + 1.month
    ev_conditions = "datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'"
    ev_conditions += " and fk_user_action in (#{todos.join(',')})"
    klass.logger.info("#{klass.name} find_regies_by_todo: ev_conditions <#{ev_conditions}>")
    actions = [] 
    ev_types = klass.where("code = 'AC_REGIE'")
    ev_types.each { |et|
      actions += et.events.where(ev_conditions)
    }
    actions.flatten!
    klass.logger.info("#{klass.name} find_regies_by_todo: Found #{actions.size} actions")
    actions
  end

  def get_actions(cal_id, params={})
    return [] if Calendar.find(cal_id).hide
    klass = eval(self.class.name)
    date = DateTime.current
    prev_month = params['startDay'].nil? ? date - 1.month : DateTime.parse(params['startDay'])
    next_month = params['endDay'].nil? ? date + 3.month : DateTime.parse(params['endDay'])

    # prev_month = date - 10.month
    # next_month = date + 10.month

    actions = [] 
    ev_types = klass.where("code not in (?, ?)", 'AC_OTH_AUTO', 'AC_REGIE')
    klass.logger.debug("#{self.class.name}: get actions EVENT TYPE <#{ev_types.to_s}>")
    conditions = "datep <= '" + next_month.to_s + "' and datep >= '" + prev_month.to_s + "' and label not regexp '^Bon de commande|^Facture FA|^Facture AV|^Proposition valid|^Société'"
    if not ev_types.nil?
      actions = ev_types.to_a.map { |et|
        events = et.events.where(conditions) || []
        events 
      }.compact
    end
    klass.logger.debug("#{self.class.name}: nbr d'actions : #{actions.size}")
    actions.to_a.flatten.map { |e| e.cal_id = cal_id }
    actions.to_a.flatten
  end


  def get_regies(cal_id, params={})
    return [] if Calendar.find(cal_id).hide
    klass = eval(self.class.name)
    regies = []
    date = DateTime.current
    # prev_month = params['startDay'].nil? ? date - 1.month : DateTime.parse(params['startDay'])
    # next_month = params['endDay'].nil? ? date + 3.month : DateTime.parse(params['endDay'])

    prev_month = date - 10.month
    next_month = date + 10.month
    
    ev_type = klass.where('code = "AC_REGIE"').first
    klass.logger.debug("#{self.class.name}: get regies EVENT TYPE <#{ev_type.to_s}>")
    if not ev_type.nil?
      events = ev_type.events
    end
    if not events.nil?
      regies = events.where("datep <= '" + next_month.to_s + "' and datep >= '" + prev_month.to_s + "'").to_a.flatten || []
    end
    regies.map { |e| e.cal_id = cal_id } 
    klass.logger.debug("#{self.class.name}: nbr de regies: #{regies.size}")
    regies.to_a.flatten
  end

end
