package org.swiftsuspenders.injectionresults
{
   import org.swiftsuspenders.Injector;
   
   public class InjectValueResult extends InjectionResult
   {
      
      private var m_value:Object;
      
      public function InjectValueResult(param1:Object)
      {
         super();
         this.m_value = param1;
      }
      
      override public function getResponse(param1:Injector) : Object
      {
         return this.m_value;
      }
      
      override public function equals(param1:InjectionResult) : Boolean
      {
         if(param1 == this)
         {
            return true;
         }
         if(!(param1 is InjectValueResult))
         {
            return false;
         }
         var _loc2_:InjectValueResult = InjectValueResult(param1);
         return _loc2_.m_value == this.m_value;
      }
   }
}

