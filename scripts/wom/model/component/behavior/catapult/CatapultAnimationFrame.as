package wom.model.component.behavior.catapult
{
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.tower.TowerDefense;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class CatapultAnimationFrame extends TowerDefense
   {
      
      public function CatapultAnimationFrame(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      override public function checkUnitToAttack(param1:Unit) : int
      {
         if(param1.data.info.typeId == 22 && param1.movement.enabled)
         {
            var _loc7_:WorkerThread = womRoot.tdrd;
            return _loc7_._value;
         }
         if(!attacksGround && !param1.data.typeDIO.flying || !attacksAir && param1.data.typeDIO.flying)
         {
            var _loc8_:WorkerThread = womRoot.tdrd;
            return _loc8_._value;
         }
         var _loc4_:Number = param1.position.point.x - position.x;
         var _loc5_:Number = param1.position.point.y - position.y;
         var _loc3_:Number = _loc4_ * _loc4_;
         var _loc2_:Number = _loc5_ * _loc5_;
         var _loc6_:Number = _loc3_ + _loc2_;
         if(r * r >= _loc3_ + _loc2_)
         {
            sss(_loc6_,param1);
            var _loc9_:WorkerThread = womRoot.tdrg;
            return _loc9_._value;
         }
         var _loc10_:WorkerThread = womRoot.tdrd;
         return _loc10_._value;
      }
      
      private function sss(param1:Number, param2:Unit) : void
      {
         if(!tu)
         {
            tu = param2;
            td = param1;
         }
         else if(param1 < td)
         {
            td = param1;
            tu = param2;
         }
      }
   }
}

