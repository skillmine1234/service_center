module Fault
  class ProcedureFault < StandardError
    attr_reader :code, :subCode, :reason, :message
    
    def initialize(fault)
      @code = fault.code
      @subCode = fault.subCode || ''
      @reason = fault.reasonText || ''
      @message = "#{fault.code} : #{fault.subCode} : #{fault.reasonText}"
    end
  end
end