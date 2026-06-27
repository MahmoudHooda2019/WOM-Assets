package wom.model.component.attribute.data
{
   public class UnitLogData
   {
      
      public var totalDamageGiven:Number;
      
      public var totalDamageTaken:Number;
      
      public var totalHealTaken:Number;
      
      public var hitCount:int;
      
      public var mightBoosted:Boolean;
      
      public function UnitLogData()
      {
         super();
         reset();
      }
      
      public function reset() : void
      {
         totalDamageGiven = totalDamageTaken = totalHealTaken = hitCount = 0;
         mightBoosted = false;
      }
   }
}

