package wom.model.component.behavior.battle.tower
{
   import flash.media.Sound;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class BurriedSpikes extends TowerDefense
   {
      
      public static const RANGE:int = 6;
      
      public static const TRIGGER_RANGE:int = 3;
      
      private var bd:BuildingData;
      
      private var damage:Number;
      
      private var triggerRange:int;
      
      private var sfx:SfxManager;
      
      private var trapSound:Sound;
      
      public function BurriedSpikes(param1:BattleManager)
      {
         super(param1,1);
      }
      
      override public function init() : void
      {
         r = 6;
         triggerRange = 3;
         super.init();
         bd = (owner as Building).data;
         damage = bd.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGE.id];
         sfx = womRoot.sfxManager;
         trapSound = sfx.assetRepository.getSoundAssetReference("BurriedSpikesAttack").soundAsset.sound;
      }
      
      override public function startAttack() : void
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:* = undefined;
         var _loc7_:int = 0;
         var _loc1_:Unit = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:BuildingViewManager = null;
         var _loc4_:Boolean = false;
         _loc9_ = iS;
         while(_loc9_ <= iF)
         {
            _loc6_ = jS;
            while(_loc6_ <= jF)
            {
               _loc8_ = (b.battleFieldControl.battleFields[(_loc9_ << 10) + (_loc6_ << 0)] as BattleField).units;
               _loc7_ = _loc8_.length - 1;
               while(_loc7_ >= 0)
               {
                  _loc1_ = _loc8_[_loc7_];
                  if(!(_loc1_.data.typeDIO.flying || _loc1_.data.info.typeId == 22 && _loc1_.movement.enabled))
                  {
                     _loc2_ = _loc1_.position.point.x - position.x;
                     _loc3_ = _loc1_.position.point.y - position.y;
                     if(_loc2_ < 0)
                     {
                        _loc2_ *= -1;
                     }
                     if(_loc3_ < 0)
                     {
                        _loc3_ *= -1;
                     }
                     if(_loc2_ <= r && _loc3_ <= r)
                     {
                        _loc1_.underAttack.hit(damage);
                        _loc4_ = true;
                     }
                  }
                  _loc7_--;
               }
               _loc6_++;
            }
            _loc9_++;
         }
         if(!_loc4_)
         {
            return;
         }
         sfx.trapActivate(trapSound,ownerBuilding);
         b.battleFieldControl.removeTowerFromCheckGrid(this);
         bd.buildingInfo.healthPoint = 0;
         b.notifier.notifyTrapActivated(ownerBuilding);
         var _loc11_:Building = ownerBuilding;
         _loc11_.validator.add(_loc11_);
         undefined;
         if(!(owner as Building).viewManager)
         {
            _loc5_ = new BuildingViewManager(ownerBuilding,bd.buildingTypeDIO);
            owner.componentManager.add(_loc5_);
            _loc5_.init();
            ownerBuilding.root.layers[3].add(ownerBuilding);
         }
         else
         {
            ownerBuilding.viewManager.manageAll();
         }
      }
      
      override public function update() : void
      {
      }
      
      override public function stopAttack(param1:Boolean = true) : void
      {
      }
      
      override public function checkUnitToAttack(param1:Unit) : int
      {
         if(param1.data.typeDIO.flying || param1.data.info.typeId == 22 && param1.movement.enabled)
         {
            var _loc4_:WorkerThread = womRoot.tdrd;
            return _loc4_._value;
         }
         var _loc2_:Number = param1.position.point.x - position.x;
         var _loc3_:Number = param1.position.point.y - position.y;
         if(_loc2_ < 0)
         {
            _loc2_ *= -1;
         }
         if(_loc3_ < 0)
         {
            _loc3_ *= -1;
         }
         if(_loc2_ <= triggerRange && _loc3_ <= triggerRange)
         {
            tu = param1;
         }
         var _loc5_:WorkerThread = womRoot.tdrg;
         return _loc5_._value;
      }
   }
}

