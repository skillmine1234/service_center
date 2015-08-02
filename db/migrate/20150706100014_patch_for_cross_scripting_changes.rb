class PatchForCrossScriptingChanges < ActiveRecord::Migration
  def change
    codes = PurposeCode.unscoped.all
    codes.each do |code|
      code.pattern_beneficiaries.gsub!(",","\r\n") unless code.pattern_beneficiaries.nil?
      code.save(:validate => false)
    end

    rules = InwRemittanceRule.all
    rules.each do |rule|
      rule.pattern_beneficiaries.gsub!(",","\r\n") unless rule.pattern_beneficiaries.nil?
      rule.pattern_corporates.gsub!(",","\r\n") unless rule.pattern_corporates.nil?
      rule.pattern_individuals.gsub!(",","\r\n") unless rule.pattern_individuals.nil?
      rule.pattern_remitters.gsub!(",","\r\n") unless rule.pattern_remitters.nil?
      rule.pattern_salutations.gsub!(",","\r\n") unless rule.pattern_salutations.nil?
      rule.save(:validate => false)
    end
  end
end
