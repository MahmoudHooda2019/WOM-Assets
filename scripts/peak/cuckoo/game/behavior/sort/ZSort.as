package peak.cuckoo.game.behavior.sort
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   
   public class ZSort extends BaseSort
   {
      
      private var ownerLayer:Layer;
      
      public function ZSort()
      {
         super();
         priority = 1;
      }
      
      public static function compareZ(param1:GameSprite, param2:GameSprite) : Number
      {
         var _loc3_:Number = param1.position.projected.z - param2.position.projected.z;
         return _loc3_ < 0 ? -1 : (_loc3_ > 0 ? 1 : 0);
      }
      
      public static function sort(param1:Vector.<GameSprite>) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:uint = param1.length;
         if(_loc4_ < 2)
         {
            return;
         }
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = _loc4_;
         while(_loc3_ != _loc6_)
         {
            switch(param1[_loc3_])
            {
               case undefined:
                  _loc6_--;
                  param1[_loc3_] = param1[_loc6_];
                  param1[_loc6_] = undefined;
                  break;
               case null:
                  param1[_loc3_] = param1[_loc5_];
                  param1[_loc5_] = null;
                  _loc5_++;
                  _loc3_++;
                  break;
               default:
                  _loc3_++;
            }
         }
         if(_loc6_ > _loc5_)
         {
            _loc3_ = _loc5_;
            while(_loc3_ < _loc6_)
            {
               _loc2_ = param1[_loc3_];
               if(_loc2_ != _loc2_)
               {
                  _loc6_--;
                  param1[_loc3_] = param1[_loc6_];
                  param1[_loc6_] = null;
               }
               else
               {
                  _loc3_++;
               }
            }
            if(--_loc6_)
            {
               if(uint(_loc6_ - 1) > _loc5_)
               {
                  quickSort(param1,_loc5_,_loc6_,0);
               }
            }
         }
      }
      
      public static function quickSort(param1:Vector.<GameSprite>, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:GameSprite = null;
         var _loc7_:uint = param1.length;
         if(param3 >= _loc7_)
         {
            param3 = _loc7_ - 1;
         }
         if(param2 >= param3)
         {
            return;
         }
         var _loc8_:uint = param3;
         var _loc10_:* = param2;
         var _loc9_:uint = param3 - param2;
         var _loc6_:GameSprite = param1[param3 + param2 >>> 1];
         while(_loc9_ >= 9)
         {
            while(param2 < param3)
            {
               if(param1[param3].position.projected.z > _loc6_.position.projected.z)
               {
                  do
                  {
                     param3--;
                  }
                  while(param1[param3].position.projected.z > _loc6_.position.projected.z);
               }
               if(param1[param2].position.projected.z < _loc6_.position.projected.z)
               {
                  do
                  {
                     param2++;
                  }
                  while(param1[param2].position.projected.z < _loc6_.position.projected.z);
               }
               if(param2 < param3)
               {
                  _loc5_ = param1[param2];
                  param1[param2] = param1[param3];
                  param1[param3] = _loc5_;
                  param2++;
                  param3--;
               }
            }
            if(param3)
            {
               if(param2 == param3)
               {
                  if(param1[param2].position.projected.z < _loc6_.position.projected.z)
                  {
                     param2++;
                  }
                  else if(param1[param3].position.projected.z > _loc6_.position.projected.z)
                  {
                     param3--;
                  }
               }
               if(_loc10_ < param3)
               {
                  quickSort(param1,_loc10_,param3,param4 + 1);
               }
            }
            else if(!param2)
            {
               param2 = 1;
            }
            if(_loc8_ <= param2)
            {
               return;
            }
            _loc10_ = param2;
            param3 = _loc8_;
            _loc6_ = param1[param3 + param2 >>> 1];
            _loc9_ = param3 - param2;
            param4++;
         }
         _loc6_ = param1[param2];
         do
         {
            do
            {
               param2++;
               if(param1[param2].position.projected.z < _loc6_.position.projected.z)
               {
                  _loc6_ = param1[param2];
                  do
                  {
                     param1[param2--] = param1[param2];
                  }
                  while(param2 > _loc10_ && _loc6_.position.projected.z < param1[param2].position.projected.z);
                  param1[param2] = _loc6_;
               }
            }
            while(param2 < param3);
            param2 = ++_loc10_;
            _loc6_ = param1[param2];
         }
         while(_loc10_ < param3);
      }
      
      override public function init() : void
      {
         super.init();
         ownerLayer = owner as Layer;
      }
      
      override public function update() : void
      {
         sort(ownerLayer.renderChildrenContainer.renderChildren);
      }
   }
}

