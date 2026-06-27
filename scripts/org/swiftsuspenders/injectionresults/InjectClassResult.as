package org.swiftsuspenders.injectionresults
{
   import org.swiftsuspenders.Injector;
   
   public class InjectClassResult extends InjectionResult
   {
      
      private var m_responseType:Class;
      
      public function InjectClassResult(param1:Class)
      {
         super();
         this.m_responseType = param1;
      }
      
      override public function getResponse(param1:Injector) : Object
      {
         return param1.instantiate(this.m_responseType);
      }
      
      override public function equals(param1:InjectionResult) : Boolean
      {
         if(param1 == this)
         {
            return true;
         }
         if(!(param1 is InjectClassResult))
         {
            return false;
         }
         var _loc2_:InjectClassResult = InjectClassResult(param1);
         return _loc2_.m_responseType == this.m_responseType;
      }
   }
}

