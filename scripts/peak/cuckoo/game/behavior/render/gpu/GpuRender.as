package peak.cuckoo.game.behavior.render.gpu
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.attribute.view.StarlingCuckooOverlay;
   import peak.cuckoo.game.behavior.animation.uv.UVActionAnimation;
   import peak.cuckoo.game.behavior.animation.uv.UVLoopAnimation;
   import peak.cuckoo.game.behavior.animation.uv.UVStateDirectionAnimation;
   import peak.cuckoo.game.behavior.render.*;
   import peak.display.TransparentInteractiveBackground;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.resource.atlas.Atlas;
   import peak.resource.atlas.AtlasManager;
   import peak.resource.atlas.starling.StarlingAtlasManager;
   import starling.display.Sprite;
   import wom.Environment;
   
   public class GpuRender extends BaseRender
   {
      
      public static const NO_FILTER:int = 0;
      
      public static const BLINK_WHITE:int = 1;
      
      public static const BYTES_PER_FLOAT:int = 4;
      
      public static const DATA32_PER_VERTEX:int = 5;
      
      public static const VERTEX_PER_QUAD:int = 4;
      
      public static const BYTES_PER_QUAD:int = 20;
      
      public static const MAX_VERTEX_COUNT:int = 49152;
      
      public var context3D:Context3D;
      
      public var backBufferWidth:int;
      
      public var backBufferHeight:int;
      
      protected var projection:Vector.<Number>;
      
      public var atlasManager:StarlingAtlasManager;
      
      private var _transparentInteractiveBackground:TransparentInteractiveBackground;
      
      protected var lastState:uint;
      
      protected const programs:Vector.<Vector.<Program3D>> = new Vector.<Vector.<Program3D>>();
      
      public var stateChanges:int;
      
      public var totalQuads:int;
      
      private var _starlingOverlay:StarlingCuckooOverlay;
      
      public var lastVertexIndex:uint;
      
      public var context3DVertexBuffer:VertexBuffer3D;
      
      public var indexBuffer:IndexBuffer3D;
      
      public var buffer:ByteArray;
      
      private var emptyNodes:VertexBufferNode;
      
      public var index:Vector.<uint> = new Vector.<uint>();
      
      private var lastIndexBufferIndex:uint;
      
      public var headBatch:Batch;
      
      public var lastBatch:Batch;
      
      public function GpuRender()
      {
         super();
         renderSpecificLoopAnimation = UVLoopAnimation;
         renderSpecificActionAnimation = UVActionAnimation;
         renderSpecificDirectionStateAnimation = UVStateDirectionAnimation;
         _starlingOverlay = new StarlingCuckooOverlay();
         _canvas.addChild(_transparentInteractiveBackground = new TransparentInteractiveBackground());
         atlasManager = AtlasManager.INSTANCE as StarlingAtlasManager;
         buffer = new ByteArray();
      }
      
      override public function init() : void
      {
         super.init();
         trace(lastVertexIndex);
         if(buffer.length == 0)
         {
            buffer.length = 4 * 5 * 49152;
            buffer.endian = "littleEndian";
            onContextComplete();
         }
         lastVertexIndex = 0;
         emptyNodes = null;
      }
      
      public function onContextComplete() : void
      {
         if(!context3D)
         {
            context3D = Environment.gpu.context3D;
            organizeGpuBuffers();
            owner.root.componentManager.add(atlasManager);
            atlasManager.init();
            createProgramsAndParameters();
            this.invalidated |= 1;
            this.arrangeCanvasAndViewport();
            this.invalidated = 0;
            for each(var _loc2_ in owner.root.layers)
            {
               for each(var _loc1_ in _loc2_.allChildrenContainer.children)
               {
                  if(_loc1_.composite && _loc2_.type == 3)
                  {
                     for each(var _loc3_ in (_loc1_.composite.view as CompositeView).children)
                     {
                        _loc3_.view.gpuImage.assetReady();
                     }
                  }
                  else
                  {
                     _loc1_.view.gpuImage.assetReady();
                  }
               }
            }
         }
      }
      
      private function organizeGpuBuffers(param1:Boolean = false) : void
      {
         var _loc2_:Number = NaN;
         if(!context3DVertexBuffer)
         {
            buffer.length = 4 * 5 * 49152;
            context3DVertexBuffer = context3D.createVertexBuffer(49152,5);
            context3DVertexBuffer.uploadFromByteArray(buffer,0,0,49152);
         }
         if(!indexBuffer)
         {
            _loc2_ = 73728;
            indexBuffer = context3D.createIndexBuffer(_loc2_);
            index.length = _loc2_;
            indexBuffer.uploadFromVector(index,0,_loc2_);
         }
      }
      
      protected function onContextLoss(param1:Event) : void
      {
         context3D = Environment.gpu.context3D;
         createProgramsAndParameters();
      }
      
      protected function createProgramsAndParameters() : void
      {
         createPrograms();
      }
      
      protected function createPrograms() : void
      {
         var _loc10_:Array = null;
         var _loc1_:String = null;
         var _loc7_:Array = null;
         var _loc2_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:ByteArray = null;
         var _loc6_:Program3D = null;
         var _loc9_:ByteArray = null;
         var _loc11_:AGALMiniAssembler = new AGALMiniAssembler();
         var _loc5_:Vector.<Boolean> = new <Boolean>[true,false];
         programs[0] = new Vector.<Program3D>(8,true);
         for each(_loc3_ in _loc5_)
         {
            for each(_loc2_ in _loc5_)
            {
               for each(_loc8_ in _loc5_)
               {
                  _loc7_ = ["m44 op, va0, vc0","mov v0, va1"];
                  if(_loc8_)
                  {
                     _loc7_.push(_loc2_ ? "mul v1.xyz, va2.xyz, va2.www\nmov v1.w, va2.w" : "mov v1, va2");
                  }
                  _loc1_ = "<2d,linear" + (_loc3_ ? ",dxt5>" : ">");
                  _loc10_ = _loc8_ ? ["tex ft0, v0, fs0 " + _loc1_,"mul oc, ft0, v1"] : ["tex oc, v0, fs0 " + _loc1_];
                  _loc9_ = _loc11_.assemble("vertex",_loc7_.join("\n"));
                  _loc4_ = _loc11_.assemble("fragment",_loc10_.join("\n"));
                  _loc6_ = context3D.createProgram();
                  _loc6_.upload(_loc9_,_loc4_);
                  var _temp_14:* = programs[0];
                  var _temp_13:* = _loc2_;
                  var _temp_12:* = _loc3_;
                  var _loc26_:Boolean = _loc8_;
                  var _loc25_:Boolean = _temp_12;
                  var _loc24_:Boolean = _temp_13;
                  §§pop()[(_temp_14 ? 1 : 0) | (_loc25_ ? 2 : 0) | (_loc26_ ? 4 : 0)] = _loc6_;
               }
            }
         }
         programs[1] = new Vector.<Program3D>(8,true);
         for each(_loc3_ in _loc5_)
         {
            for each(_loc2_ in _loc5_)
            {
               for each(_loc8_ in _loc5_)
               {
                  _loc7_ = ["m44 op, va0, vc0","mov v0, va1"];
                  if(_loc8_)
                  {
                     _loc7_.push(_loc2_ ? "mul v1.xyz, va2.xyz, va2.www\nmov v1.w, va2.w" : "mov v1, va2");
                  }
                  _loc1_ = "<2d,linear" + (_loc3_ ? ",dxt5>" : ">");
                  _loc10_ = _loc8_ ? ["tex ft0, v0, fs0 " + _loc1_,"mul ft1, ft0, v1","mul oc, ft1, fc0"] : ["tex ft0, v0, fs0 " + _loc1_,"mul oc, ft0, fc0"];
                  _loc9_ = _loc11_.assemble("vertex",_loc7_.join("\n"));
                  _loc4_ = _loc11_.assemble("fragment",_loc10_.join("\n"));
                  _loc6_ = context3D.createProgram();
                  _loc6_.upload(_loc9_,_loc4_);
                  var _temp_26:* = programs[1];
                  var _temp_25:* = _loc2_;
                  var _temp_24:* = _loc3_;
                  var _loc29_:Boolean = _loc8_;
                  var _loc28_:Boolean = _temp_24;
                  var _loc27_:Boolean = _temp_25;
                  §§pop()[(_temp_26 ? 1 : 0) | (_loc28_ ? 2 : 0) | (_loc29_ ? 4 : 0)] = _loc6_;
               }
            }
         }
      }
      
      final protected function getProgramId(param1:Boolean, param2:Boolean, param3:Boolean) : uint
      {
         return (param1 ? 1 : 0) | (param2 ? 2 : 0) | (param3 ? 4 : 0);
      }
      
      override public function arrangeCanvasAndViewport() : void
      {
         super.arrangeCanvasAndViewport();
         var _loc1_:Number = owner.root.scale / Environment.starling.contentScaleFactor;
         if(invalidated & (1 | 4))
         {
            _transparentInteractiveBackground.resize(viewport.rect.width,viewport.rect.height);
            if(context3D)
            {
               if(_effectiveClipCanvas)
               {
                  invalidated |= 1;
               }
               projection = new <Number>[2 / owner.root.viewport.rect.width,0,0,-1,0,-2 / owner.root.viewport.rect.height,0,1,0,0,-1,0,0,0,1,1];
               context3D.setProgramConstantsFromVector("vertex",0,projection,4);
               if(invalidated & 1 && (backBufferWidth != _effectiveCanvasRect.width || backBufferHeight != _effectiveCanvasRect.height))
               {
                  log(LoggerContexts.RENDER,"GpuRender: configuring backbuffer",_effectiveCanvasRect);
                  backBufferWidth = _effectiveCanvasRect.width;
                  backBufferHeight = _effectiveCanvasRect.height;
                  context3D.configureBackBuffer(backBufferWidth,backBufferHeight,0,false);
               }
            }
            _starlingOverlay.scaleX = _starlingOverlay.scaleY = _loc1_;
         }
         _starlingOverlay.x = -viewport.rect.x * _loc1_;
         _starlingOverlay.y = -viewport.rect.y * _loc1_;
      }
      
      override public function update() : void
      {
         if(!context3D)
         {
            return;
         }
         super.update();
      }
      
      override protected function beginScene() : Boolean
      {
         try
         {
            context3D.clear();
         }
         catch(e:Error)
         {
            return false;
         }
         stateChanges = 0;
         totalQuads = 0;
         return true;
      }
      
      override protected function presentScene() : void
      {
         context3D.present();
      }
      
      override protected function renderScene() : void
      {
         var _loc3_:Batch = null;
         var _loc4_:Atlas = null;
         context3DVertexBuffer.uploadFromByteArray(buffer,0,0,lastVertexIndex);
         Environment.gpu.context3D.setVertexBufferAt(0,context3DVertexBuffer,0,"float2");
         Environment.gpu.context3D.setVertexBufferAt(1,context3DVertexBuffer,2,"float2");
         lastIndexBufferIndex = 0;
         headBatch = null;
         renderLayer(owner.root.layers[0]);
         renderLayer(owner.root.layers[1]);
         renderLayer(owner.root.layers[2]);
         renderMainLayer(owner.root.layers[3]);
         renderLayer(owner.root.layers[4]);
         finishCurrentBatch();
         indexBuffer.uploadFromVector(index,0,lastIndexBufferIndex);
         var _loc2_:Atlas = null;
         var _loc1_:Boolean = headBatch.tinted;
         if(_loc1_)
         {
            Environment.gpu.context3D.setVertexBufferAt(2,context3DVertexBuffer,4,"bytes4");
         }
         _loc3_ = headBatch;
         while(_loc3_)
         {
            stateChanges = stateChanges + 1;
            if(_loc1_ != _loc3_.tinted)
            {
               if(_loc3_.tinted)
               {
                  Environment.gpu.context3D.setVertexBufferAt(2,context3DVertexBuffer,4,"bytes4");
               }
               else
               {
                  Environment.gpu.context3D.setVertexBufferAt(2,null);
               }
               _loc1_ = _loc3_.tinted;
            }
            _loc4_ = _loc3_.atlas;
            if(_loc2_ != _loc4_)
            {
               context3D.setTextureAt(0,_loc4_.texture);
               if(!_loc2_ || _loc2_.premultipliedAlpha != _loc4_.premultipliedAlpha)
               {
                  if(_loc4_.premultipliedAlpha)
                  {
                     context3D.setBlendFactors("one","oneMinusSourceAlpha");
                  }
                  else
                  {
                     context3D.setBlendFactors("sourceAlpha","oneMinusSourceAlpha");
                  }
               }
               _loc2_ = _loc4_;
            }
            §§push(context3D);
            var _temp_7:* = programs[_loc3_.filter];
            var _temp_6:* = _loc4_.premultipliedAlpha;
            var _temp_5:* = _loc4_.compressed;
            var _loc7_:Boolean = _loc3_.tinted;
            var _loc6_:Boolean = _temp_5;
            var _loc5_:Boolean = _temp_6;
            §§pop().setProgram(§§pop()[(_temp_7 ? 1 : 0) | (_loc6_ ? 2 : 0) | (_loc7_ ? 4 : 0)]);
            context3D.drawTriangles(indexBuffer,_loc3_.startIndex,_loc3_.numberOfTriangles);
            _loc3_ = _loc3_.next;
         }
      }
      
      private function renderMainLayer(param1:Layer) : void
      {
         var _loc3_:* = null;
         for each(var _loc2_ in param1.renderChildrenContainer.renderChildren)
         {
            if(_loc2_.composite)
            {
               for each(_loc3_ in (_loc2_.composite.view as CompositeView).children)
               {
                  var _loc8_:GpuImage = _loc3_.view.gpuImage;
                  if(_loc8_.ready)
                  {
                     this.totalQuads++;
                     if(this.lastState != _loc8_.state)
                     {
                        this.finishCurrentBatch();
                        this.lastState = _loc8_.state;
                     }
                     this.index[this.lastIndexBufferIndex++] = _loc8_.vertexBufferIndex + 0;
                     this.index[this.lastIndexBufferIndex++] = _loc8_.vertexBufferIndex + 1;
                     this.index[this.lastIndexBufferIndex++] = _loc8_.vertexBufferIndex + 2;
                     this.index[this.lastIndexBufferIndex++] = _loc8_.vertexBufferIndex + 3;
                     this.index[this.lastIndexBufferIndex++] = _loc8_.vertexBufferIndex + 2;
                     this.index[this.lastIndexBufferIndex++] = _loc8_.vertexBufferIndex + 1;
                  }
               }
            }
            else
            {
               var _loc9_:GpuImage = _loc2_.view.gpuImage;
               if(_loc9_.ready)
               {
                  this.totalQuads++;
                  if(this.lastState != _loc9_.state)
                  {
                     this.finishCurrentBatch();
                     this.lastState = _loc9_.state;
                  }
                  this.index[this.lastIndexBufferIndex++] = _loc9_.vertexBufferIndex + 0;
                  this.index[this.lastIndexBufferIndex++] = _loc9_.vertexBufferIndex + 1;
                  this.index[this.lastIndexBufferIndex++] = _loc9_.vertexBufferIndex + 2;
                  this.index[this.lastIndexBufferIndex++] = _loc9_.vertexBufferIndex + 3;
                  this.index[this.lastIndexBufferIndex++] = _loc9_.vertexBufferIndex + 2;
                  this.index[this.lastIndexBufferIndex++] = _loc9_.vertexBufferIndex + 1;
               }
            }
         }
      }
      
      private function renderLayer(param1:Layer) : void
      {
         if(param1)
         {
            for each(var _loc2_ in param1.renderChildrenContainer.renderChildren)
            {
               var _loc5_:GpuImage = _loc2_.view.gpuImage;
               if(_loc5_.ready)
               {
                  this.totalQuads++;
                  if(this.lastState != _loc5_.state)
                  {
                     this.finishCurrentBatch();
                     this.lastState = _loc5_.state;
                  }
                  this.index[this.lastIndexBufferIndex++] = _loc5_.vertexBufferIndex + 0;
                  this.index[this.lastIndexBufferIndex++] = _loc5_.vertexBufferIndex + 1;
                  this.index[this.lastIndexBufferIndex++] = _loc5_.vertexBufferIndex + 2;
                  this.index[this.lastIndexBufferIndex++] = _loc5_.vertexBufferIndex + 3;
                  this.index[this.lastIndexBufferIndex++] = _loc5_.vertexBufferIndex + 2;
                  this.index[this.lastIndexBufferIndex++] = _loc5_.vertexBufferIndex + 1;
               }
            }
         }
      }
      
      final public function draw(param1:GpuImage) : void
      {
         if(!param1.ready)
         {
            return;
         }
         totalQuads = totalQuads + 1;
         if(lastState != param1.state)
         {
            finishCurrentBatch();
            lastState = param1.state;
         }
         index[lastIndexBufferIndex++] = param1.vertexBufferIndex + 0;
         index[lastIndexBufferIndex++] = param1.vertexBufferIndex + 1;
         index[lastIndexBufferIndex++] = param1.vertexBufferIndex + 2;
         index[lastIndexBufferIndex++] = param1.vertexBufferIndex + 3;
         index[lastIndexBufferIndex++] = param1.vertexBufferIndex + 2;
         index[lastIndexBufferIndex++] = param1.vertexBufferIndex + 1;
      }
      
      final public function finishCurrentBatch() : void
      {
         if(lastIndexBufferIndex == 0)
         {
            return;
         }
         var _loc1_:uint = uint(lastState >> 16);
         var _loc3_:int = lastState >> 8 & 0xFF;
         var _loc2_:Boolean = (lastState & 0xFF) != 0;
         if(!headBatch)
         {
            headBatch = lastBatch = new Batch(atlasManager.atlasArchive[_loc1_],_loc3_,_loc2_,0,lastIndexBufferIndex);
         }
         else if(lastBatch.atlas.index == _loc1_ && lastBatch.filter == _loc3_ && lastBatch.tinted && lastIndexBufferIndex - lastBatch.lastIndex < 192)
         {
            lastBatch.lastIndex = lastIndexBufferIndex;
            lastBatch.numberOfTriangles = (lastBatch.lastIndex - lastBatch.startIndex) / 3;
         }
         else
         {
            lastBatch.next = new Batch(atlasManager.atlasArchive[_loc1_],_loc3_,_loc2_,lastBatch.lastIndex,lastIndexBufferIndex);
            lastBatch = lastBatch.next;
         }
      }
      
      override public function set canvasRect(param1:Rectangle) : void
      {
         super.canvasRect = param1;
      }
      
      override public function prepareView(param1:BaseView) : void
      {
         param1.owner.componentManager.add(param1.gpuImage = new GpuImage());
         param1.gpuImage.init();
      }
      
      override public function updateView(param1:BaseView) : void
      {
         param1.gpuImage.assetReady();
      }
      
      public function get starlingOverlay() : Sprite
      {
         return _starlingOverlay;
      }
      
      public function addToVertexBuffer(param1:GpuImage) : void
      {
         if(param1.vertexBufferIndex != 0)
         {
            param1.setVertexBuffer(param1.vertexBufferIndex);
         }
         else if(emptyNodes)
         {
            param1.setVertexBuffer(emptyNodes.index);
            emptyNodes = emptyNodes.next;
         }
         else
         {
            param1.setVertexBuffer(lastVertexIndex);
            lastVertexIndex += 4;
         }
      }
      
      public function removeFromVertexBuffer(param1:GpuImage) : void
      {
         if(param1.vertexBufferIndex != 0)
         {
            emptyNodes = new VertexBufferNode(emptyNodes,param1.vertexBufferIndex);
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

import peak.resource.atlas.Atlas;

class VertexBufferNode
{
   
   public var next:VertexBufferNode;
   
   public var index:uint;
   
   public function VertexBufferNode(param1:VertexBufferNode, param2:uint)
   {
      super();
      this.next = param1;
      this.index = param2;
   }
}

class Batch
{
   
   public var atlas:Atlas;
   
   public var filter:uint;
   
   public var tinted:Boolean;
   
   public var startIndex:uint;
   
   public var lastIndex:uint;
   
   public var numberOfTriangles:uint;
   
   public var next:Batch;
   
   public function Batch(param1:Atlas, param2:uint, param3:Boolean, param4:uint, param5:uint)
   {
      super();
      this.atlas = param1;
      this.filter = param2;
      this.tinted = param3;
      this.startIndex = param4;
      this.lastIndex = param5;
      this.numberOfTriangles = (param5 - param4) / 3;
   }
}
