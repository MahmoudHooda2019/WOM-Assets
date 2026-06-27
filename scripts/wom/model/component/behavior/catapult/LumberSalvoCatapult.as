package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.AssetView;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Drop;
   import wom.model.dto.combat.CatapultInfo;
   
   public class LumberSalvoCatapult extends RainingTypeCatapault
   {
      
      public function LumberSalvoCatapult(param1:BattleManager, param2:CatapultInfo)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         super.init();
         catapultSound = sfx.assetRepository.getSoundAssetReference("SfxLumberSalvo").soundAsset.sound;
         offset = new Point(21,26);
      }
      
      override protected function handleDrops() : void
      {
         var _loc5_:int = 0;
         var _loc1_:Drop = null;
         var _loc4_:String = null;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         _loc5_ = drops.length - 1;
         while(_loc5_ >= 0)
         {
            _loc1_ = drops[_loc5_];
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
                     hittingEnabled = true;
                     _loc1_.position.projected = _loc1_.target;
                     _loc1_.state = 2;
                     (womRoot.layers[4] as Layer).remove(_loc1_);
                     _loc1_.dx = 60;
                     _loc1_.dy = Math.random() * 3 >> 0;
                     _loc4_ = "LumberWShadow" + (_loc1_.dy + 1);
                     (_loc1_.view as AssetView).changeAsset(_loc4_);
                     (womRoot.layers[2] as Layer).add(_loc1_);
                  }
                  var _loc6_:Drop = _loc1_;
                  _loc6_.validator.add(_loc6_);
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
                     drops.splice(_loc5_,1);
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
            _loc5_--;
         }
         if(!_loc3_ && hittingEnabled)
         {
            hitLastDamage();
            hittingEnabled = false;
         }
      }
      
      override protected function getAssetId() : String
      {
         var _loc1_:int = Math.random() * 3 + 1;
         return "Lumber" + _loc1_;
      }
   }
}

