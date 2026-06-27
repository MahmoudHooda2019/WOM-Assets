package feathers.controls
{
   import feathers.core.FeathersControl;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.textures.Texture;
   import starling.utils.RectangleUtil;
   
   public class ImageLoader extends FeathersControl
   {
      
      protected static const ATF_FILE_EXTENSION:String = "atf";
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_RECTANGLE:Rectangle = new Rectangle();
      
      private static const HELPER_RECTANGLE2:Rectangle = new Rectangle();
      
      protected static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);
      
      LOADER_CONTEXT.imageDecodingPolicy = "onLoad";
      
      protected var image:Image;
      
      protected var loader:Loader;
      
      protected var urlLoader:URLLoader;
      
      protected var _lastURL:String;
      
      protected var _currentTextureFrame:Rectangle;
      
      protected var _currentTexture:Texture;
      
      protected var _texture:Texture;
      
      protected var _textureBitmapData:BitmapData;
      
      protected var _textureRawData:ByteArray;
      
      protected var _isTextureOwner:Boolean = false;
      
      protected var _source:Object;
      
      protected var _loadingTexture:Texture;
      
      protected var _errorTexture:Texture;
      
      protected var _isLoaded:Boolean = false;
      
      private var _textureScale:Number = 1;
      
      private var _smoothing:String = "bilinear";
      
      private var _color:uint = 16777215;
      
      private var _snapToPixels:Boolean = false;
      
      private var _maintainAspectRatio:Boolean = true;
      
      protected var _pendingBitmapDataTexture:BitmapData;
      
      protected var _pendingRawTextureData:ByteArray;
      
      protected var _delayTextureCreation:Boolean = false;
      
      protected var _paddingTop:Number = 0;
      
      protected var _paddingRight:Number = 0;
      
      protected var _paddingBottom:Number = 0;
      
      protected var _paddingLeft:Number = 0;
      
      public function ImageLoader()
      {
         super();
         this.isQuickHitAreaEnabled = true;
      }
      
      public function get source() : Object
      {
         return this._source;
      }
      
      public function set source(param1:Object) : void
      {
         if(this._source == param1)
         {
            return;
         }
         this._source = param1;
         this.cleanupTexture();
         if(this.image)
         {
            this.image.visible = false;
         }
         this._lastURL = null;
         this._isLoaded = false;
         this.invalidate("data");
      }
      
      public function get loadingTexture() : Texture
      {
         return this._loadingTexture;
      }
      
      public function set loadingTexture(param1:Texture) : void
      {
         if(this._loadingTexture == param1)
         {
            return;
         }
         this._loadingTexture = param1;
         this.invalidate("styles");
      }
      
      public function get errorTexture() : Texture
      {
         return this._errorTexture;
      }
      
      public function set errorTexture(param1:Texture) : void
      {
         if(this._errorTexture == param1)
         {
            return;
         }
         this._errorTexture = param1;
         this.invalidate("styles");
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function get textureScale() : Number
      {
         return this._textureScale;
      }
      
      public function set textureScale(param1:Number) : void
      {
         if(this._textureScale == param1)
         {
            return;
         }
         this._textureScale = param1;
         this.invalidate("size");
      }
      
      public function get smoothing() : String
      {
         return this._smoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         if(this._smoothing == param1)
         {
            return;
         }
         this._smoothing = param1;
         this.invalidate("styles");
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         this.invalidate("styles");
      }
      
      public function get snapToPixels() : Boolean
      {
         return this._snapToPixels;
      }
      
      public function set snapToPixels(param1:Boolean) : void
      {
         if(this._snapToPixels == param1)
         {
            return;
         }
         this._snapToPixels = param1;
      }
      
      public function get maintainAspectRatio() : Boolean
      {
         return this._maintainAspectRatio;
      }
      
      public function set maintainAspectRatio(param1:Boolean) : void
      {
         if(this._maintainAspectRatio == param1)
         {
            return;
         }
         this._maintainAspectRatio = param1;
         this.invalidate("layout");
      }
      
      public function get originalSourceWidth() : Number
      {
         if(this._currentTextureFrame)
         {
            return this._currentTextureFrame.width;
         }
         return 0;
      }
      
      public function get originalSourceHeight() : Number
      {
         if(this._currentTextureFrame)
         {
            return this._currentTextureFrame.height;
         }
         return 0;
      }
      
      public function get delayTextureCreation() : Boolean
      {
         return this._delayTextureCreation;
      }
      
      public function set delayTextureCreation(param1:Boolean) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:ByteArray = null;
         if(this._delayTextureCreation == param1)
         {
            return;
         }
         this._delayTextureCreation = param1;
         if(!this._delayTextureCreation)
         {
            if(this._pendingBitmapDataTexture)
            {
               _loc2_ = this._pendingBitmapDataTexture;
               this._pendingBitmapDataTexture = null;
               this.replaceBitmapDataTexture(_loc2_);
            }
            if(this._pendingRawTextureData)
            {
               _loc3_ = this._pendingRawTextureData;
               this._pendingRawTextureData = null;
               this.replaceRawTextureData(_loc3_);
            }
         }
      }
      
      public function get padding() : Number
      {
         return this._paddingTop;
      }
      
      public function set padding(param1:Number) : void
      {
         this.paddingTop = param1;
         this.paddingRight = param1;
         this.paddingBottom = param1;
         this.paddingLeft = param1;
      }
      
      public function get paddingTop() : Number
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         if(this._paddingTop == param1)
         {
            return;
         }
         this._paddingTop = param1;
         this.invalidate("styles");
      }
      
      public function get paddingRight() : Number
      {
         return this._paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         if(this._paddingRight == param1)
         {
            return;
         }
         this._paddingRight = param1;
         this.invalidate("styles");
      }
      
      public function get paddingBottom() : Number
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         if(this._paddingBottom == param1)
         {
            return;
         }
         this._paddingBottom = param1;
         this.invalidate("styles");
      }
      
      public function get paddingLeft() : Number
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         if(this._paddingLeft == param1)
         {
            return;
         }
         this._paddingLeft = param1;
         this.invalidate("styles");
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         if(this._snapToPixels)
         {
            this.getTransformationMatrix(this.stage,HELPER_MATRIX);
            param1.translateMatrix(Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx,Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty);
         }
         super.render(param1,param2);
         if(this._snapToPixels)
         {
            param1.translateMatrix(-(Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx),-(Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty));
         }
      }
      
      override public function dispose() : void
      {
         if(this.loader)
         {
            this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
            this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
            this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
            try
            {
               this.loader.close();
            }
            catch(error:Error)
            {
            }
            this.loader = null;
         }
         this.cleanupTexture();
         super.dispose();
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = this.isInvalid("data");
         var _loc4_:Boolean = this.isInvalid("layout");
         var _loc3_:Boolean = this.isInvalid("styles");
         var _loc1_:Boolean = this.isInvalid("size");
         if(_loc2_)
         {
            this.commitData();
         }
         if(_loc2_ || _loc3_)
         {
            this.commitStyles();
         }
         _loc1_ = this.autoSizeIfNeeded() || _loc1_;
         if(_loc2_ || _loc4_ || _loc1_ || _loc3_)
         {
            this.layout();
         }
      }
      
      protected function autoSizeIfNeeded() : Boolean
      {
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Boolean = isNaN(this.explicitWidth);
         var _loc4_:Boolean = isNaN(this.explicitHeight);
         if(!_loc2_ && !_loc4_)
         {
            return false;
         }
         var _loc3_:Number = this.explicitWidth;
         if(_loc2_)
         {
            if(this._currentTextureFrame)
            {
               _loc3_ = this._currentTextureFrame.width * this._textureScale;
               if(!_loc4_)
               {
                  _loc6_ = this.explicitHeight / (this._currentTextureFrame.height * this._textureScale);
                  _loc3_ *= _loc6_;
               }
            }
            else
            {
               _loc3_ = 0;
            }
            _loc3_ += this._paddingLeft + this._paddingRight;
         }
         var _loc1_:Number = this.explicitHeight;
         if(_loc4_)
         {
            if(this._currentTextureFrame)
            {
               _loc1_ = this._currentTextureFrame.height * this._textureScale;
               if(!_loc2_)
               {
                  _loc5_ = this.explicitWidth / (this._currentTextureFrame.width * this._textureScale);
                  _loc1_ *= _loc5_;
               }
            }
            else
            {
               _loc1_ = 0;
            }
            _loc1_ += this._paddingTop + this._paddingBottom;
         }
         return this.setSizeInternal(_loc3_,_loc1_,false);
      }
      
      protected function commitData() : void
      {
         var _loc1_:String = null;
         if(this._source is Texture)
         {
            this._lastURL = null;
            this._texture = Texture(this._source);
            this.refreshCurrentTexture();
            this._isLoaded = true;
         }
         else
         {
            _loc1_ = this._source as String;
            if(!_loc1_)
            {
               this._lastURL = null;
            }
            else if(_loc1_ != this._lastURL)
            {
               this._lastURL = _loc1_;
               if(this.urlLoader)
               {
                  this.urlLoader.removeEventListener("complete",rawDataLoader_completeHandler);
                  this.urlLoader.removeEventListener("ioError",rawDataLoader_errorHandler);
                  this.urlLoader.removeEventListener("securityError",rawDataLoader_errorHandler);
                  try
                  {
                     this.urlLoader.close();
                  }
                  catch(error:Error)
                  {
                  }
               }
               if(this.loader)
               {
                  this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
                  this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
                  this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
                  try
                  {
                     this.loader.close();
                  }
                  catch(error:Error)
                  {
                  }
               }
               if(_loc1_.toLowerCase().lastIndexOf("atf") == _loc1_.length - 3)
               {
                  if(this.loader)
                  {
                     this.loader = null;
                  }
                  if(!this.urlLoader)
                  {
                     this.urlLoader = new URLLoader();
                     this.urlLoader.dataFormat = "binary";
                  }
                  this.urlLoader.addEventListener("complete",rawDataLoader_completeHandler);
                  this.urlLoader.addEventListener("ioError",rawDataLoader_errorHandler);
                  this.urlLoader.addEventListener("securityError",rawDataLoader_errorHandler);
                  this.urlLoader.load(new URLRequest(_loc1_));
                  return;
               }
               if(this.urlLoader)
               {
                  this.urlLoader = null;
               }
               if(!this.loader)
               {
                  this.loader = new Loader();
               }
               this.loader.contentLoaderInfo.addEventListener("complete",loader_completeHandler);
               this.loader.contentLoaderInfo.addEventListener("ioError",loader_errorHandler);
               this.loader.contentLoaderInfo.addEventListener("securityError",loader_errorHandler);
               this.loader.load(new URLRequest(_loc1_),LOADER_CONTEXT);
            }
            this.refreshCurrentTexture();
         }
      }
      
      protected function commitStyles() : void
      {
         if(!this.image)
         {
            return;
         }
         this.image.smoothing = this._smoothing;
         this.image.color = this._color;
      }
      
      protected function layout() : void
      {
         if(!this.image || !this._currentTexture)
         {
            return;
         }
         if(this._maintainAspectRatio)
         {
            HELPER_RECTANGLE.x = 0;
            HELPER_RECTANGLE.y = 0;
            HELPER_RECTANGLE.width = this._currentTextureFrame.width * this._textureScale;
            HELPER_RECTANGLE.height = this._currentTextureFrame.height * this._textureScale;
            HELPER_RECTANGLE2.x = 0;
            HELPER_RECTANGLE2.y = 0;
            HELPER_RECTANGLE2.width = this.actualWidth - this._paddingLeft - this._paddingRight;
            HELPER_RECTANGLE2.height = this.actualHeight - this._paddingTop - this._paddingBottom;
            RectangleUtil.fit(HELPER_RECTANGLE,HELPER_RECTANGLE2,"showAll",false,HELPER_RECTANGLE);
            this.image.x = HELPER_RECTANGLE.x + this._paddingLeft;
            this.image.y = HELPER_RECTANGLE.y + this._paddingTop;
            this.image.width = HELPER_RECTANGLE.width;
            this.image.height = HELPER_RECTANGLE.height;
         }
         else
         {
            this.image.x = this._paddingLeft;
            this.image.y = this._paddingTop;
            this.image.width = this.actualWidth - this._paddingLeft - this._paddingRight;
            this.image.height = this.actualHeight - this._paddingTop - this._paddingBottom;
         }
      }
      
      protected function refreshCurrentTexture() : void
      {
         var _loc1_:Texture = this._texture;
         if(!_loc1_)
         {
            if(this.loader)
            {
               _loc1_ = this._loadingTexture;
            }
            else
            {
               _loc1_ = this._errorTexture;
            }
         }
         if(this._currentTexture == _loc1_)
         {
            return;
         }
         this._currentTexture = _loc1_;
         if(!this._currentTexture)
         {
            if(this.image)
            {
               this.removeChild(this.image,true);
               this.image = null;
            }
            return;
         }
         this._currentTextureFrame = this._currentTexture.frame;
         if(!this.image)
         {
            this.image = new Image(this._currentTexture);
            this.addChild(this.image);
         }
         else
         {
            this.image.texture = this._currentTexture;
            this.image.readjustSize();
         }
         this.image.visible = true;
      }
      
      protected function cleanupTexture() : void
      {
         if(this._isTextureOwner)
         {
            if(this._textureBitmapData)
            {
               this._textureBitmapData.dispose();
            }
            if(this._textureRawData)
            {
               this._textureRawData.clear();
            }
            if(this._texture)
            {
               this._texture.dispose();
            }
         }
         if(this._pendingBitmapDataTexture)
         {
            this._pendingBitmapDataTexture.dispose();
         }
         if(this._pendingRawTextureData)
         {
            this._pendingRawTextureData.clear();
         }
         this._currentTexture = null;
         this._currentTextureFrame = null;
         this._pendingBitmapDataTexture = null;
         this._pendingRawTextureData = null;
         this._textureBitmapData = null;
         this._textureRawData = null;
         this._texture = null;
         this._isTextureOwner = false;
      }
      
      protected function replaceBitmapDataTexture(param1:BitmapData) : void
      {
         this._texture = Texture.fromBitmapData(param1,false);
         if(Starling.handleLostContext)
         {
            this._textureBitmapData = param1;
         }
         else
         {
            param1.dispose();
         }
         this._isTextureOwner = true;
         this._isLoaded = true;
         this.invalidate("data");
         this.dispatchEventWith("complete");
      }
      
      protected function replaceRawTextureData(param1:ByteArray) : void
      {
         this._texture = Texture.fromAtfData(param1);
         if(Starling.handleLostContext)
         {
            this._textureRawData = param1;
         }
         else
         {
            param1.clear();
         }
         this._isTextureOwner = true;
         this._isLoaded = true;
         this.invalidate("data");
         this.dispatchEventWith("complete");
      }
      
      protected function loader_completeHandler(param1:Event) : void
      {
         var _loc3_:Bitmap = Bitmap(this.loader.content);
         this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
         this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
         this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
         this.loader = null;
         this.cleanupTexture();
         var _loc2_:BitmapData = _loc3_.bitmapData;
         if(this._delayTextureCreation)
         {
            this._pendingBitmapDataTexture = _loc2_;
         }
         else
         {
            this.replaceBitmapDataTexture(_loc2_);
         }
      }
      
      protected function loader_errorHandler(param1:ErrorEvent) : void
      {
         this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
         this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
         this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
         this.loader = null;
         this.cleanupTexture();
         this.invalidate("data");
         this.dispatchEventWith("error",false,param1);
      }
      
      protected function rawDataLoader_completeHandler(param1:Event) : void
      {
         var _loc2_:ByteArray = ByteArray(this.urlLoader.data);
         this.urlLoader.removeEventListener("complete",rawDataLoader_completeHandler);
         this.urlLoader.removeEventListener("ioError",rawDataLoader_errorHandler);
         this.urlLoader.removeEventListener("securityError",rawDataLoader_errorHandler);
         this.urlLoader = null;
         this.cleanupTexture();
         if(this._delayTextureCreation)
         {
            this._pendingRawTextureData = _loc2_;
         }
         else
         {
            this.replaceRawTextureData(_loc2_);
         }
      }
      
      protected function rawDataLoader_errorHandler(param1:ErrorEvent) : void
      {
         this.urlLoader.removeEventListener("complete",rawDataLoader_completeHandler);
         this.urlLoader.removeEventListener("ioError",rawDataLoader_errorHandler);
         this.urlLoader.removeEventListener("securityError",rawDataLoader_errorHandler);
         this.urlLoader = null;
         this.cleanupTexture();
         this.invalidate("data");
         this.dispatchEventWith("error",false,param1);
      }
   }
}

