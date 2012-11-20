package
{
    import flash.display.NativeMenu;
    import flash.display.NativeMenuItem;
    import flash.events.Event;
    import flash.ui.Keyboard;
    
    public class MainMenu extends NativeMenu
    {
        private var _menuItemList:Vector.<NativeMenuItem>;
        private var _menuItemIndex:Vector.<String>;
        private var _enable:Boolean;
        private var _clearRecentProject:NativeMenuItem;
 //       private var _recentProjectList:NativeMenu;
        public function MainMenu()
        {
            super();
            
            _menuItemList = new Vector.<NativeMenuItem>();
            _menuItemIndex = new Vector.<String>(); 
            
            var subMenu:NativeMenu;
            subMenu = new NativeMenu();
			
            integrateSubMenu(subMenu, new EditorMenuItem("新建",  "new", false));
            integrateSubMenu(subMenu, new EditorMenuItem("打开",  "open", false));
            integrateSubMenu(subMenu, new EditorMenuItem("保存",  "save", false));
			
			addSubmenu(subMenu, "  文件  ");
        }
        
        
        protected function integrateSubMenu(subMenu:NativeMenu, subMenuItem:NativeMenuItem):NativeMenuItem
        {
            subMenu.addItem(subMenuItem);
            subMenuItem.addEventListener(Event.SELECT, onMenuItemSelected);
            _menuItemList.push(subMenuItem);
            _menuItemIndex.push(String(subMenuItem.data));
            return subMenuItem;
        }
        
        protected function onMenuItemSelected(e:Event):void
        {
            var menuItem:NativeMenuItem = (e.currentTarget as NativeMenuItem);
            var type:String;
            if(menuItem.data)
            {
                type = String(menuItem.data);
            }
            dispatchEvent(new Event(type));
        }
	}
}
        
import flash.display.NativeMenuItem;
import flash.ui.Keyboard;

class EditorMenuItem extends NativeMenuItem 
{
    private var _needEnable:Boolean;
    public function EditorMenuItem(label:String,
                                   eventType:String,
                                   needEnable:Boolean,
                                   hostKey:String = null,
                                   useCtrl:Boolean = false,
                                   useShift:Boolean = false,
                                   useAlt:Boolean = false)
    {
        super(label);
        data = eventType;
        keyEquivalent = hostKey;
        var equivalentModifiers:Array = [];
        if(useCtrl) equivalentModifiers.push(Keyboard.CONTROL);
        if(useAlt) equivalentModifiers.push(Keyboard.ALTERNATE);
        if(useShift) equivalentModifiers.push(Keyboard.SHIFT);
        keyEquivalentModifiers = equivalentModifiers;
        
        _needEnable = needEnable;
    }
    
    public function get needEnable():Boolean {return _needEnable };
}