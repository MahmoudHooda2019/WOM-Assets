package wom.model.component.behavior.battle.hit
{
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class SingleHit extends BaseHit
   {
      
      public function SingleHit()
      {
         super();
      }
      
      override public function hitUnit(param1:Unit) : void
      {
         var _loc3_:WorkerThread = ownerUnit.data.damage;
         var _loc2_:Number = _loc3_._value;
         try
         {
            param1.underAttack.hit(_loc2_);
            ownerUnit.data.unitLog.totalDamageGiven += _loc2_;
            ownerUnit.data.unitLog.hitCount++;
            insurance = 0;
         }
         catch(e:Error)
         {
            if(++insurance == 3)
            {
               hitFinished.dispatch(ownerUnit);
            }
         }
         ownerUnit.data.unitLog.totalDamageGiven += _loc2_;
         ownerUnit.data.unitLog.hitCount++;
      }
      
      override public function hitBuilding(param1:Building) : void
      {
         var _loc3_:WorkerThread = ownerUnit.data.damage;
         var _loc2_:Number = _loc3_._value;
         try
         {
            param1.underAttack.hit(_loc2_,lootAmount);
            ownerUnit.data.unitLog.totalDamageGiven += _loc2_;
            ownerUnit.data.unitLog.hitCount++;
            insurance = 0;
         }
         catch(e:Error)
         {
            if(++insurance == 3)
            {
               hitFinished.dispatch(ownerUnit);
            }
         }
      }
      
      override public function hit(param1:Number, param2:Number, param3:Boolean = false) : void
      {
      }
   }
}

