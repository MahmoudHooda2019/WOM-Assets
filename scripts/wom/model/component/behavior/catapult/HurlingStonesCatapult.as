package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.AssetView;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Drop;
   import wom.model.dto.combat.CatapultInfo;
   
   public class HurlingStonesCatapult extends RainingTypeCatapault
   {
      
      public function HurlingStonesCatapult(param1:BattleManager, param2:CatapultInfo)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         super.init();
         catapultSound = sfx.assetRepository.getSoundAssetReference("SfxHurlingStones").soundAsset.sound;
         offset = new Point(21,26);
      }
      
      override protected function handleDrops() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Drop = null;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         _loc4_ = drops.length - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = drops[_loc4_];
            switch(int(_loc1_.state) - 1)
            {
               case 0:
                  _loc3_ = true;
                  if(_loc1_.position.projected.x < _loc1_.target.x)
                  {
                     _loc1_.position.projected.x += _loc1_.dx * sync.precise;
                     _loc1_.position.projected.y += _loc1_.dy * sync.precise;
                  }
                  else
                  {
                     if(!hittingEnabled)
                     {
                        hittingEnabled = true;
                        womRoot.earthquake.startEarthquake();
                     }
                     _loc1_.position.projected = _loc1_.target;
                     _loc1_.state = 2;
                     (womRoot.layers[4] as Layer).remove(_loc1_);
                     _loc1_.dx = 60;
                     (_loc1_.view as AssetView).changeAsset("StoneCrater");
                     _loc1_.target.z = 0;
                     womRoot.particle3DAnimationManager.spillSoil(_loc1_.target);
                     (womRoot.layers[2] as Layer).add(_loc1_);
                  }
                  var _loc5_:Drop = _loc1_;
                  _loc5_.validator.add(_loc5_);
                  undefined;
                  break;
               case 1:
                  _loc1_.dx -= sync.precise;
                  if(_loc1_.dx <= 0)
                  {
                     _loc1_.state = 3;
                     _loc1_.dx = 0;
                     _loc1_.velocity = 0;
                  }
                  break;
               case 2:
                  _loc1_.dx += sync.precise;
                  if(_loc1_.dx >= 60)
                  {
                     drops.splice(_loc4_,1);
                     (womRoot.layers[2] as Layer).remove(_loc1_);
                     womRoot.removeChild(_loc1_);
                     _loc1_.destroy();
                  }
                  else
                  {
                     _loc2_ = _loc1_.dx / 60;
                     _loc1_.view.alphaFilter(1 - _loc2_);
                  }
            }
            _loc4_--;
         }
         if(!_loc3_ && hittingEnabled)
         {
            hitLastDamage();
            womRoot.earthquake.endEarthquake();
            hittingEnabled = false;
         }
      }
      
      override protected function getAssetId() : String
      {
         return "Stone1";
      }
   }
}

