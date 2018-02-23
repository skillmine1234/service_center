module Fault
  class ProcedureFault < StandardError
    attr_reader :code, :subCode, :reason, :message
    
    def initialize(fault)
      @code = fault.code
      @subCode = fault.subCode || ''
      @reason = fault.reasonText || ''
      @message = "Code :- #{fault.code} : Subcode :- #{fault.subCode} : Reason :- #{fault.reasonText}"
    end
  end
end