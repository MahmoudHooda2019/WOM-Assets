package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.PropertyProxy;
   import feathers.core.ToggleGroup;
   import feathers.data.ListCollection;
   import starling.events.Event;
   
   public class TabBar extends FeathersControl
   {
      
      protected static const INVALIDATION_FLAG_TAB_FACTORY:String = "tabFactory";
      
      protected static const NOT_PENDING_INDEX:int = -2;
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
      
      public static const DEFAULT_CHILD_NAME_TAB:String = "feathers-tab-bar-tab";
      
      private static const DEFAULT_TAB_FIELDS:Vector.<String> = new <String>["defaultIcon","upIcon","downIcon","hoverIcon","disabledIcon","defaultSelectedIcon","selectedUpIcon","selectedDownIcon","selectedHoverIcon","selectedDisabledIcon"];
      
      protected var tabName:String = "feathers-tab-bar-tab";
      
      protected var firstTabName:String = "feathers-tab-bar-tab";
      
      protected var lastTabName:String = "feathers-tab-bar-tab";
      
      protected var toggleGroup:ToggleGroup;
      
      protected var activeFirstTab:Button;
      
      protected var inactiveFirstTab:Button;
      
      protected var activeLastTab:Button;
      
      protected var inactiveLastTab:Button;
      
      protected var activeTabs:Vector.<Button> = new Vector.<Button>(0);
      
      protected var inactiveTabs:Vector.<Button> = new Vector.<Button>(0);
      
      protected var _dataProvider:ListCollection;
      
      protected var _direction:String = "horizontal";
      
      protected var _gap:Number = 0;
      
      protected var _tabFactory:Function = defaultTabFactory;
      
      protected var _firstTabFactory:Function;
      
      protected var _lastTabFactory:Function;
      
      protected var _tabInitializer:Function;
      
      protected var _ignoreSelectionChanges:Boolean = false;
      
      protected var _pendingSelectedIndex:int = -2;
      
      protected var _customTabName:String;
      
      protected var _customFirstTabName:String;
      
      protected var _customLastTabName:String;
      
      protected var _tabProperties:PropertyProxy;
      
      public function TabBar()
      {
         _tabInitializer = defaultTabInitializer;
         super();
      }
      
      protected static function defaultTabFactory() : Button
      {
         return new Button();
      }
      
      public function get dataProvider() : ListCollection
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:ListCollection) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         if(this._dataProvider)
         {
            this._dataProvider.removeEventListener("addItem",dataProvider_addItemHandler);
            this._dataProvider.removeEventListener("removeItem",dataProvider_removeItemHandler);
            this._dataProvider.removeEventListener("replaceItem",dataProvider_replaceItemHandler);
            this._dataProvider.removeEventListener("updateItem",dataProvider_updateItemHandler);
            this._dataProvider.removeEventListener("reset",dataProvider_resetHandler);
         }
         this._dataProvider = param1;
         if(this._dataProvider)
         {
            this._dataProvider.addEventListener("addItem",dataProvider_addItemHandler);
            this._dataProvider.addEventListener("removeItem",dataProvider_removeItemHandler);
            this._dataProvider.addEventListener("replaceItem",dataProvider_replaceItemHandler);
            this._dataProvider.addEventListener("updateItem",dataProvider_updateItemHandler);
            this._dataProvider.addEventListener("reset",dataProvider_resetHandler);
            if(this.selectedIndex < 0 && this._dataProvider.length > 0)
            {
               this.selectedIndex = 0;
            }
         }
         else
         {
            this.selectedIndex = -1;
         }
         this.invalidate("data");
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         if(this._direction == param1)
         {
            return;
         }
         this._direction = param1;
         this.invalidate("styles");
      }
      
      public function get gap() : Number
      {
         return this._gap;
      }
      
      public function set gap(param1:Number) : void
      {
         if(this._gap == param1)
         {
            return;
         }
         this._gap = param1;
         this.invalidate("styles");
      }
      
      public function get tabFactory() : Function
      {
         return this._tabFactory;
      }
      
      public function set tabFactory(param1:Function) : void
      {
         if(this._tabFactory == param1)
         {
            return;
         }
         this._tabFactory = param1;
         this.invalidate("tabFactory");
      }
      
      public function get firstTabFactory() : Function
      {
         return this._firstTabFactory;
      }
      
      public function set firstTabFactory(param1:Function) : void
      {
         if(this._firstTabFactory == param1)
         {
            return;
         }
         this._firstTabFactory = param1;
         this.invalidate("tabFactory");
      }
      
      public function get lastTabFactory() : Function
      {
         return this._lastTabFactory;
      }
      
      public function set lastTabFactory(param1:Function) : void
      {
         if(this._lastTabFactory == param1)
         {
            return;
         }
         this._lastTabFactory = param1;
         this.invalidate("tabFactory");
      }
      
      public function get tabInitializer() : Function
      {
         return this._tabInitializer;
      }
      
      public function set tabInitializer(param1:Function) : void
      {
         if(this._tabInitializer == param1)
         {
            return;
         }
         this._tabInitializer = param1;
         this.invalidate("data");
      }
      
      public function get selectedIndex() : int
      {
         if(this._pendingSelectedIndex != -2)
         {
            return this._pendingSelectedIndex;
         }
         if(!this.toggleGroup)
         {
            return -1;
         }
         return this.toggleGroup.selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this._pendingSelectedIndex == param1 || this._pendingSelectedIndex == -2 && this.toggleGroup && this.toggleGroup.selectedIndex == param1)
         {
            return;
         }
         this._pendingSelectedIndex = param1;
         this.invalidate("selected");
      }
      
      public function get selectedItem() : Object
      {
         var _loc1_:int = this.selectedIndex;
         if(!this._dataProvider || _loc1_ < 0 || _loc1_ >= this._dataProvider.length)
         {
            return null;
         }
         return this._dataProvider.getItemAt(_loc1_);
      }
      
      public function set selectedItem(param1:Object) : void
      {
         this.selectedIndex = this._dataProvider.getItemIndex(param1);
      }
      
      public function get customTabName() : String
      {
         return this._customTabName;
      }
      
      public function set customTabName(param1:String) : void
      {
         if(this._customTabName == param1)
         {
            return;
         }
         this._customTabName = param1;
         this.invalidate("tabFactory");
      }
      
      public function get customFirstTabName() : String
      {
         return this._customFirstTabName;
      }
      
      public function set customFirstTabName(param1:String) : void
      {
         if(this._customFirstTabName == param1)
         {
            return;
         }
         this._customFirstTabName = param1;
         this.invalidate("tabFactory");
      }
      
      public function get customLastTabName() : String
      {
         return this._customLastTabName;
      }
      
      public function set customLastTabName(param1:String) : void
      {
         if(this._customLastTabName == param1)
         {
            return;
         }
         this._customLastTabName = param1;
         this.invalidate("tabFactory");
      }
      
      public function get tabProperties() : Object
      {
         if(!this._tabProperties)
         {
            this._tabProperties = new PropertyProxy(childProperties_onChange);
         }
         return this._tabProperties;
      }
      
      public function set tabProperties(param1:Object) : void
      {
         var _loc3_:PropertyProxy = null;
         if(this._tabProperties == param1)
         {
            return;
         }
         if(!param1)
         {
            param1 = new PropertyProxy();
         }
         if(!(param1 is PropertyProxy))
         {
            _loc3_ = new PropertyProxy();
            for(var _loc2_ in param1)
            {
               _loc3_[_loc2_] = param1[_loc2_];
            }
            param1 = _loc3_;
         }
         if(this._tabProperties)
         {
            this._tabProperties.removeOnChangeCallback(childProperties_onChange);
         }
         this._tabProperties = PropertyProxy(param1);
         if(this._tabProperties)
         {
            this._tabProperties.addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      override public function dispose() : void
      {
         this.dataProvider = null;
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         this.toggleGroup = new ToggleGroup();
         this.toggleGroup.isSelectionRequired = true;
         this.toggleGroup.addEventListener("change",toggleGroup_changeHandler);
      }
      
      override protected function draw() : void
      {
         var _loc4_:Boolean = this.isInvalid("data");
         var _loc6_:Boolean = this.isInvalid("styles");
         var _loc5_:Boolean = this.isInvalid("state");
         var _loc2_:Boolean = this.isInvalid("selected");
         var _loc1_:Boolean = this.isInvalid("tabFactory");
         var _loc3_:Boolean = this.isInvalid("size");
         if(_loc4_ || _loc1_)
         {
            this.refreshTabs(_loc1_);
         }
         if(_loc4_ || _loc1_ || _loc6_)
         {
            this.refreshTabStyles();
         }
         if(_loc4_ || _loc1_ || _loc2_)
         {
            this.commitSelection();
         }
         if(_loc4_ || _loc1_ || _loc5_)
         {
            this.commitEnabled();
         }
         _loc3_ = this.autoSizeIfNeeded() || _loc3_;
         if(_loc3_ || _loc4_ || _loc1_ || _loc6_)
         {
            this.layoutTabs();
         }
      }
      
      protected function commitSelection() : void
      {
         if(this._pendingSelectedIndex == -2 || !this.toggleGroup)
         {
            return;
         }
         if(this.toggleGroup.selectedIndex == this._pendingSelectedIndex)
         {
            this._pendingSelectedIndex = -2;
            return;
         }
         this.toggleGroup.selectedIndex = this._pendingSelectedIndex;
         this._pendingSelectedIndex = -2;
         this.dispatchEventWith("change");
      }
      
      protected function commitEnabled() : void
      {
         for each(var _loc1_ in this.activeTabs)
         {
            _loc1_.isEnabled = this._isEnabled;
         }
      }
      
      protected function refreshTabStyles() : void
      {
         var _loc2_:Object = null;
         for each(var _loc3_ in this.activeTabs)
         {
            for(var _loc1_ in this._tabProperties)
            {
               _loc2_ = this._tabProperties[_loc1_];
               if(_loc3_.hasOwnProperty(_loc1_))
               {
                  _loc3_[_loc1_] = _loc2_;
               }
            }
         }
      }
      
      protected function defaultTabInitializer(param1:Button, param2:Object) : void
      {
         if(param2 is Object)
         {
            if(param2.hasOwnProperty("label"))
            {
               param1.label = param2.label;
            }
            else
            {
               param1.label = param2.toString();
            }
            for each(var _loc3_ in DEFAULT_TAB_FIELDS)
            {
               if(param2.hasOwnProperty(_loc3_))
               {
                  param1[_loc3_] = param2[_loc3_];
               }
            }
         }
         else
         {
            param1.label = "";
         }
      }
      
      protected function refreshTabs(param1:Boolean) : void
      {
         var _loc9_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Button = null;
         var _loc3_:int = 0;
         var _loc10_:Boolean = this._ignoreSelectionChanges;
         this._ignoreSelectionChanges = true;
         var _loc4_:int = this.toggleGroup.selectedIndex;
         this.toggleGroup.removeAllItems();
         var _loc7_:Vector.<Button> = this.inactiveTabs;
         this.inactiveTabs = this.activeTabs;
         this.activeTabs = _loc7_;
         this.activeTabs.length = 0;
         _loc7_ = null;
         if(param1)
         {
            this.clearInactiveTabs();
         }
         else
         {
            if(this.activeFirstTab)
            {
               this.inactiveTabs.shift();
            }
            this.inactiveFirstTab = this.activeFirstTab;
            if(this.activeLastTab)
            {
               this.inactiveTabs.pop();
            }
            this.inactiveLastTab = this.activeLastTab;
         }
         this.activeFirstTab = null;
         this.activeLastTab = null;
         var _loc8_:int = int(this._dataProvider ? this._dataProvider.length : 0);
         var _loc2_:int = _loc8_ - 1;
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc5_ = this._dataProvider.getItemAt(_loc9_);
            if(_loc9_ == 0)
            {
               _loc6_ = this.activeFirstTab = this.createFirstTab(_loc5_);
            }
            else if(_loc9_ == _loc2_)
            {
               _loc6_ = this.activeLastTab = this.createLastTab(_loc5_);
            }
            else
            {
               _loc6_ = this.createTab(_loc5_);
            }
            this.toggleGroup.addItem(_loc6_);
            this.activeTabs.push(_loc6_);
            _loc9_++;
         }
         this.clearInactiveTabs();
         this._ignoreSelectionChanges = _loc10_;
         if(_loc4_ >= 0)
         {
            _loc3_ = this.activeTabs.length - 1;
            if(_loc4_ < _loc3_)
            {
               _loc3_ = _loc4_;
            }
            this._ignoreSelectionChanges = _loc4_ == _loc3_;
            this.toggleGroup.selectedIndex = _loc3_;
            this._ignoreSelectionChanges = _loc10_;
         }
      }
      
      protected function clearInactiveTabs() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Button = null;
         var _loc2_:int = int(this.inactiveTabs.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.inactiveTabs.shift();
            this.destroyTab(_loc1_);
            _loc3_++;
         }
         if(this.inactiveFirstTab)
         {
            this.destroyTab(this.inactiveFirstTab);
            this.inactiveFirstTab = null;
         }
         if(this.inactiveLastTab)
         {
            this.destroyTab(this.inactiveLastTab);
            this.inactiveLastTab = null;
         }
      }
      
      protected function createFirstTab(param1:Object) : Button
      {
         var _loc2_:Button = null;
         var _loc3_:Function = null;
         if(this.inactiveFirstTab)
         {
            _loc2_ = this.inactiveFirstTab;
            this.inactiveFirstTab = null;
         }
         else
         {
            _loc3_ = this._firstTabFactory != null ? this._firstTabFactory : this._tabFactory;
            _loc2_ = Button(_loc3_());
            if(this._customFirstTabName)
            {
               _loc2_.nameList.add(this._customFirstTabName);
            }
            else if(this._customTabName)
            {
               _loc2_.nameList.add(this._customTabName);
            }
            else
            {
               _loc2_.nameList.add(this.firstTabName);
            }
            _loc2_.isToggle = true;
            this.addChild(_loc2_);
         }
         this._tabInitializer(_loc2_,param1);
         return _loc2_;
      }
      
      protected function createLastTab(param1:Object) : Button
      {
         var _loc2_:Button = null;
         var _loc3_:Function = null;
         if(this.inactiveLastTab)
         {
            _loc2_ = this.inactiveLastTab;
            this.inactiveLastTab = null;
         }
         else
         {
            _loc3_ = this._lastTabFactory != null ? this._lastTabFactory : this._tabFactory;
            _loc2_ = Button(_loc3_());
            if(this._customLastTabName)
            {
               _loc2_.nameList.add(this._customLastTabName);
            }
            else if(this._customTabName)
            {
               _loc2_.nameList.add(this._customTabName);
            }
            else
            {
               _loc2_.nameList.add(this.lastTabName);
            }
            _loc2_.isToggle = true;
            this.addChild(_loc2_);
         }
         this._tabInitializer(_loc2_,param1);
         return _loc2_;
      }
      
      protected function createTab(param1:Object) : Button
      {
         var _loc2_:Button = null;
         if(this.inactiveTabs.length == 0)
         {
            _loc2_ = this._tabFactory();
            if(this._customTabName)
            {
               _loc2_.nameList.add(this._customTabName);
            }
            else
            {
               _loc2_.nameList.add(this.tabName);
            }
            _loc2_.isToggle = true;
            this.addChild(_loc2_);
         }
         else
         {
            _loc2_ = this.inactiveTabs.shift();
         }
         this._tabInitializer(_loc2_,param1);
         return _loc2_;
      }
      
      protected function destroyTab(param1:Button) : void
      {
         this.toggleGroup.removeItem(param1);
         this.removeChild(param1,true);
      }
      
      protected function autoSizeIfNeeded() : Boolean
      {
         var _loc2_:Boolean = isNaN(this.explicitWidth);
         var _loc5_:Boolean = isNaN(this.explicitHeight);
         if(!_loc2_ && !_loc5_)
         {
            return false;
         }
         var _loc3_:Number = this.explicitWidth;
         var _loc1_:Number = this.explicitHeight;
         if(_loc2_)
         {
            _loc3_ = 0;
            for each(var _loc4_ in this.activeTabs)
            {
               _loc4_.validate();
               _loc3_ = Math.max(_loc4_.width,_loc3_);
            }
            if(this._direction == "horizontal")
            {
               _loc3_ = this.activeTabs.length * (_loc3_ + this._gap) - this._gap;
            }
         }
         if(_loc5_)
         {
            _loc1_ = 0;
            for each(_loc4_ in this.activeTabs)
            {
               _loc4_.validate();
               _loc1_ = Math.max(_loc4_.height,_loc1_);
            }
            if(this._direction != "horizontal")
            {
               _loc1_ = this.activeTabs.length * (_loc1_ + this._gap) - this._gap;
            }
         }
         return this.setSizeInternal(_loc3_,_loc1_,false);
      }
      
      protected function layoutTabs() : void
      {
         var _loc6_:int = 0;
         var _loc3_:Button = null;
         var _loc7_:int = int(this.activeTabs.length);
         var _loc5_:Number = this._direction == "vertical" ? this.actualHeight : this.actualWidth;
         var _loc2_:Number = _loc5_ - this._gap * (_loc7_ - 1);
         var _loc4_:Number = _loc2_ / _loc7_;
         var _loc1_:Number = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc3_ = this.activeTabs[_loc6_];
            if(this._direction == "vertical")
            {
               _loc3_.width = this.actualWidth;
               _loc3_.height = _loc4_;
               _loc3_.x = 0;
               _loc3_.y = _loc1_;
               _loc1_ += _loc3_.height + this._gap;
            }
            else
            {
               _loc3_.width = _loc4_;
               _loc3_.height = this.actualHeight;
               _loc3_.x = _loc1_;
               _loc3_.y = 0;
               _loc1_ += _loc3_.width + this._gap;
            }
            _loc3_.validate();
            _loc6_++;
         }
      }
      
      protected function childProperties_onChange(param1:PropertyProxy, param2:String) : void
      {
         this.invalidate("styles");
      }
      
      protected function toggleGroup_changeHandler(param1:Event) : void
      {
         if(this._ignoreSelectionChanges || this._pendingSelectedIndex != -2)
         {
            return;
         }
         this.dispatchEventWith("change");
      }
      
      protected function dataProvider_addItemHandler(param1:Event, param2:int) : void
      {
         if(this.toggleGroup && this.toggleGroup.selectedIndex >= param2)
         {
            this._pendingSelectedIndex = this.toggleGroup.selectedIndex + 1;
            this.invalidate("selected");
         }
         this.invalidate("data");
      }
      
      protected function dataProvider_removeItemHandler(param1:Event, param2:int) : void
      {
         if(this.toggleGroup && this.toggleGroup.selectedIndex > param2)
         {
            this._pendingSelectedIndex = this.toggleGroup.selectedIndex - 1;
            this.invalidate("selected");
         }
         this.invalidate("data");
      }
      
      protected function dataProvider_resetHandler(param1:Event) : void
      {
         if(this.toggleGroup && this._dataProvider.length > 0)
         {
            this._pendingSelectedIndex = 0;
            this.invalidate("selected");
         }
         this.invalidate("data");
      }
      
      protected function dataProvider_replaceItemHandler(param1:Event, param2:int) : void
      {
         this.invalidate("data");
      }
      
      protected function dataProvider_updateItemHandler(param1:Event, param2:int) : void
      {
         this.invalidate("data");
      }
   }
}

