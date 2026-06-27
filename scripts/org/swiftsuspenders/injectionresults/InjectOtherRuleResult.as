package org.swiftsuspenders.injectionresults
{
   import org.swiftsuspenders.InjectionConfig;
   import org.swiftsuspenders.Injector;
   
   public class InjectOtherRuleResult extends InjectionResult
   {
      
      private var m_rule:InjectionConfig;
      
      public function InjectOtherRuleResult(param1:InjectionConfig)
      {
         super();
         this.m_rule = param1;
      }
      
      override public function getResponse(param1:Injector) : Object
      {
         return this.m_rule.getResponse(param1);
      }
      
      override public function equals(param1:InjectionResult) : Boolean
      {
         if(param1 == this)
         {
            return true;
         }
         if(!(param1 is InjectOtherRuleResult))
         {
            return false;
         }
         var _loc2_:InjectOtherRuleResult = InjectOtherRuleResult(param1);
         return _loc2_.m_rule == this.m_rule;
      }
   }
}

