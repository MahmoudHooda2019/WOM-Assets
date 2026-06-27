package wom.model.component.behavior.battle.hit
{
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.battle.BattleFieldControl;
   import wom.model.component.behavior.battle.underatack.UnderAttackBuilding;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.game.unit.UnitStatusType;
   
   public class SplashHit extends BaseHit
   {
      
      private var bfc:BattleFieldControl;
      
      private var womRoot:WomGameRoot;
      
      private var range:Number;
      
      private var unitAttacker:Boolean;
      
      private var buildingAttacker:Boolean;
      
      private var ranged:Boolean;
      
      public function SplashHit()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         womRoot = owner.root as WomGameRoot;
         bfc = womRoot.battleManager.battleFieldControl;
         ranged = ownerUnit.data.range != 0;
         range = ownerUnit.data.typeDIO.splashRange;
         unitAttacker = ownerUnit.data.info.typeId != 29;
         buildingAttacker = ownerUnit.data.info.typeId != 34;
      }
      
      override public function hitUnit(param1:Unit) : void
      {
         hit(param1.position.point.x,param1.position.point.y,param1.position.point.z > 5);
      }
      
      override public function hitBuilding(param1:Building) : void
      {
         var _loc2_:int = 0;
         if(ranged)
         {
            _loc2_ = param1.data.buildingTypeDIO.baseSize / 2;
            hit(param1.position.point.x + _loc2_,param1.position.point.y + _loc2_);
         }
         else
         {
            hit(ownerUnit.position.point.x,ownerUnit.position.point.y);
         }
      }
      
      override public function hit(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         var _loc25_:* = 0;
         var _loc19_:* = 0;
         var _loc26_:BattleField = null;
         var _loc24_:* = undefined;
         var _loc21_:Unit = null;
         var _loc20_:int = 0;
         var _loc16_:Building = null;
         var _loc13_:Building = null;
         var _loc5_:UnderAttackBuilding = null;
         var _loc11_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc17_:int = 0;
         var _loc7_:Number = NaN;
         var _loc29_:WorkerThread = ownerUnit.data.damage;
         var _loc18_:Number = _loc29_._value;
         var _loc27_:int = (param1 - range) / 10;
         var _loc4_:int = (param1 + range) / 10;
         var _loc9_:int = (param2 - range) / 10;
         var _loc12_:int = (param2 + range) / 10;
         if(_loc27_ < 0)
         {
            _loc27_--;
         }
         if(_loc4_ > 0)
         {
            _loc4_++;
         }
         if(_loc9_ < 0)
         {
            _loc9_--;
         }
         if(_loc12_ > 0)
         {
            _loc12_++;
         }
         var _loc8_:Vector.<Building> = new Vector.<Building>();
         _loc25_ = _loc27_;
         while(_loc25_ <= _loc4_)
         {
            _loc19_ = _loc9_;
            while(_loc19_ <= _loc12_)
            {
               _loc26_ = bfc.battleFields[(_loc25_ << 10) + (_loc19_ << 0)] as BattleField;
               if(_loc26_)
               {
                  if(unitAttacker)
                  {
                     if(attacker)
                     {
                        _loc24_ = _loc26_.defenceUnits;
                     }
                     else
                     {
                        _loc24_ = _loc26_.units;
                     }
                     _loc20_ = _loc24_.length - 1;
                     while(_loc20_ >= 0)
                     {
                        _loc21_ = _loc24_[_loc20_];
                        if((_loc21_.position.point.z > 5 && param3 || _loc21_.position.point.z <= 5 && !param3) && (_loc21_.position.point.x - param1) * (_loc21_.position.point.x - param1) + (_loc21_.position.point.y - param2) * (_loc21_.position.point.y - param2) <= range * range)
                        {
                           if(_loc21_.data && _loc21_.data.info && _loc21_.data.info.status != UnitStatusType.IN_WATCH_POST)
                           {
                              _loc21_.underAttack.hit(_loc18_);
                           }
                        }
                        _loc20_--;
                     }
                  }
                  if(attacker && buildingAttacker)
                  {
                     _loc20_ = 0;
                     while(_loc20_ < _loc26_.buildings.length)
                     {
                        _loc16_ = _loc26_.buildings[_loc20_];
                        if(!_loc16_.data.buildingTypeDIO.indestructable)
                        {
                           if(_loc8_.indexOf(_loc16_) == -1)
                           {
                              _loc8_.push(_loc16_);
                           }
                        }
                        _loc20_++;
                     }
                  }
               }
               _loc19_++;
            }
            _loc25_++;
         }
         _loc25_ = 0;
         while(_loc25_ < _loc8_.length)
         {
            _loc13_ = _loc8_[_loc25_];
            if(!_loc13_.underAttack)
            {
               _loc5_ = new UnderAttackBuilding(womRoot.battleManager);
               _loc13_.componentManager.add(_loc13_.underAttack = _loc5_);
               _loc5_.init();
            }
            _loc11_ = false;
            _loc10_ = _loc13_.data.buildingTypeDIO.baseSize / 2;
            _loc22_ = _loc13_.position.point.x + _loc10_ - param1;
            _loc6_ = _loc13_.position.point.y + _loc10_ - param2;
            _loc23_ = Math.sqrt(_loc22_ * _loc22_ + _loc6_ * _loc6_);
            if(_loc23_ < range)
            {
               _loc11_ = true;
            }
            else
            {
               _loc28_ = range / _loc23_;
               _loc14_ = _loc22_ * _loc28_ + param1;
               _loc15_ = _loc6_ * _loc28_ + param2;
               _loc17_ = _loc13_.data.buildingTypeDIO.baseSize - _loc13_.data.buildingTypeDIO.pathMargin * 2;
               if(_loc13_.position.point.x + _loc13_.data.buildingTypeDIO.pathMargin <= _loc14_ && _loc13_.position.point.x + _loc17_ >= _loc14_ && _loc13_.position.point.y + _loc13_.data.buildingTypeDIO.pathMargin <= _loc15_ && _loc13_.position.point.y + _loc17_ >= _loc15_)
               {
                  _loc11_ = true;
               }
            }
            if(_loc11_)
            {
               if(_loc13_.data.buildingTypeDIO.kind.id == 11 || _loc13_.data.buildingTypeDIO.kind.id == 10 || _loc13_.data.buildingTypeDIO.kind.id == 12)
               {
                  _loc7_ = _loc18_;
                  if(_loc13_.data.buildingInfo.level == 0)
                  {
                     _loc7_ = 0;
                  }
               }
               else
               {
                  _loc7_ = 0;
               }
               if(!_loc13_.underAttack)
               {
                  _loc13_.componentManager.add(_loc13_.underAttack = new UnderAttackBuilding(womRoot.battleManager));
                  _loc13_.underAttack.init();
               }
               _loc13_.underAttack.hit(_loc18_,_loc7_);
            }
            _loc25_++;
         }
      }
   }
}

