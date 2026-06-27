package feathers.textures
{
   import flash.geom.Rectangle;
   import starling.textures.Texture;
   
   public final class Scale3Textures
   {
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
      
      private var _texture:Texture;
      
      private var _firstRegionSize:Number;
      
      private var _secondRegionSize:Number;
      
      private var _direction:String;
      
      private var _first:Texture;
      
      private var _second:Texture;
      
      private var _third:Texture;
      
      public function Scale3Textures(param1:Texture, param2:Number, param3:Number, param4:String = "horizontal")
      {
         super();
         this._texture = param1;
         this._firstRegionSize = param2;
         this._secondRegionSize = param3;
         this._direction = param4;
         this.initialize();
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function get firstRegionSize() : Number
      {
         return this._firstRegionSize;
      }
      
      public function get secondRegionSize() : Number
      {
         return this._secondRegionSize;
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function get first() : Texture
      {
         return this._first;
      }
      
      public function get second() : Texture
      {
         return this._second;
      }
      
      public function get third() : Texture
      {
         return this._third;
      }
      
      private function initialize() : void
      {
         var _loc13_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc14_:Rectangle = null;
         var _loc16_:Rectangle = null;
         var _loc7_:Rectangle = null;
         var _loc9_:Rectangle = null;
         var _loc8_:Rectangle = null;
         var _loc3_:Rectangle = null;
         var _loc6_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:Rectangle = texture.frame;
         if(this._direction == "vertical")
         {
            _loc13_ = _loc2_.height - this._firstRegionSize - this._secondRegionSize;
         }
         else
         {
            _loc13_ = _loc2_.width - this._firstRegionSize - this._secondRegionSize;
         }
         if(this._direction == "vertical")
         {
            _loc1_ = this._firstRegionSize + _loc2_.y;
            _loc15_ = _loc13_ - (_loc2_.height - texture.height) - _loc2_.y;
            _loc12_ = _loc1_ != this._firstRegionSize;
            _loc11_ = _loc2_.width - _loc2_.x != texture.width;
            _loc4_ = _loc15_ != _loc13_;
            _loc5_ = _loc2_.x != 0;
            _loc14_ = new Rectangle(0,0,texture.width,_loc1_);
            _loc16_ = _loc5_ || _loc11_ || _loc12_ ? new Rectangle(_loc2_.x,_loc2_.y,_loc2_.width,this._firstRegionSize) : null;
            this._first = Texture.fromTexture(texture,_loc14_,_loc16_);
            _loc7_ = new Rectangle(0,_loc1_,texture.width,this._secondRegionSize);
            _loc9_ = _loc5_ || _loc11_ ? new Rectangle(_loc2_.x,0,_loc2_.width,this._secondRegionSize) : null;
            this._second = Texture.fromTexture(texture,_loc7_,_loc9_);
            _loc8_ = new Rectangle(0,_loc1_ + this._secondRegionSize,texture.width,_loc15_);
            _loc3_ = _loc5_ || _loc11_ || _loc4_ ? new Rectangle(_loc2_.x,0,_loc2_.width,_loc13_) : null;
            this._third = Texture.fromTexture(texture,_loc8_,_loc3_);
         }
         else
         {
            _loc6_ = this._firstRegionSize + _loc2_.x;
            _loc10_ = _loc13_ - (_loc2_.width - texture.width) - _loc2_.x;
            _loc12_ = _loc2_.y != 0;
            _loc11_ = _loc10_ != _loc13_;
            _loc4_ = _loc2_.height - _loc2_.y != texture.height;
            _loc5_ = _loc6_ != this._firstRegionSize;
            _loc14_ = new Rectangle(0,0,_loc6_,texture.height);
            _loc16_ = _loc5_ || _loc12_ || _loc4_ ? new Rectangle(_loc2_.x,_loc2_.y,this._firstRegionSize,_loc2_.height) : null;
            this._first = Texture.fromTexture(texture,_loc14_,_loc16_);
            _loc7_ = new Rectangle(_loc6_,0,this._secondRegionSize,texture.height);
            _loc9_ = _loc12_ || _loc4_ ? new Rectangle(0,_loc2_.y,this._secondRegionSize,_loc2_.height) : null;
            this._second = Texture.fromTexture(texture,_loc7_,_loc9_);
            _loc8_ = new Rectangle(_loc6_ + this._secondRegionSize,0,_loc10_,texture.height);
            _loc3_ = _loc12_ || _loc4_ || _loc11_ ? new Rectangle(0,_loc2_.y,_loc13_,_loc2_.height) : null;
            this._third = Texture.fromTexture(texture,_loc8_,_loc3_);
         }
      }
   }
}

