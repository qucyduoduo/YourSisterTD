package common.utils
{
	import common.utils.interfaces.IMap;
	
	import flash.utils.Dictionary;
	
	public class HashMap implements IMap
	{
		private var _name:String;
		private var _keys:Array = null;
		private var props:Dictionary = null;
		
		/**
		 * 
		 * 实例化哈希表 
		 * 
		 */		
		public function HashMap(strName:String = null)
		{
			if(strName != null)
			{
				this._name = strName;
			}
			this.clear();
		}
		/**
		 *
		 * 清空表(创建新的实例引用) 
		 * 
		 */		
		public function clear():void{
			this.props = new Dictionary();
			this._keys = new Array();
		}
		/**
		 *
		 * 键查询 
		 * @param key
		 * @return 
		 * 
		 */		
		public function containsKey(key:Object):Boolean
		{
			return this.props[key] != null;
		}
		/**
		 *
		 * 值查询 
		 * @param value
		 * @return 
		 * 
		 */		
		public function containsValue(value:Object):Boolean
		{
			var result:Boolean = false;
			var len:uint = this.size();
			if(len > 0)
			{
				for(var i:uint = 0 ; i < len ; i++)
				{
					if(this.props[this._keys[i]] == value) return true;
				}
			}
			return false;
		}
		/**
		 *
		 * 根据键取值 
		 * @param key
		 * @return 
		 * 
		 */		
		public function get(key:Object):Object
		{
			return this.props[key];
		}
		/**
		 *
		 * 填入键值 
		 * @param key
		 * @param value
		 * @return 
		 * 
		 */		
		public function put(key:Object,value:Object):Object
		{
			var result:Object = null;
			if(this.containsKey(key))
			{
				result = this.get(key);
				this.props[key] = value;
			}
			else
			{
				this.props[key] = value;
				this._keys.push(key);
			}
			
			//trace("[" + this._name + "] " + key + " = " + value);
			return result;
		}
		/**
		 *
		 * 移除键值 
		 * @param key
		 * @return 
		 * 
		 */		
		public function remove(key:Object):Object
		{
			var result:Object = null;
			if(this.containsKey(key))
			{
				delete this.props[key];
				var index:int = this._keys.indexOf(key);
				if(index > -1)
				{
					this._keys.splice(index,1);
				}
			}
			return result;
		}
		/**
		 *
		 * 复制哈希表 
		 * @param map
		 * 
		 */		
		public function putAll(map:IMap):void
		{
			this.clear();
			var len:uint = map.size();
			if(len > 0)
			{
				var arr:Array = map.keys as Array;
				for(var i:uint=0;i<len;i++)
				{
					this.put(arr[i],map.get(arr[i]));
				}
			}
		}
		/**
		 *
		 * 返回表长度 
		 * @return 
		 * 
		 */		
		public function size():uint
		{
			return this._keys.length;
		}
		/**
		 *
		 * 是否为空表 
		 * @return 
		 * 
		 */		
		public function isEmpty():Boolean
		{
			if(this.size() < 1)
				return true;
			else
				return false;
		}
		/**
		 *
		 * 返回整个值表，根据键顺序(队列)
		 * @return 
		 * 
		 */		
		public function values():Array
		{
			var result:Array = new Array();
			var len:uint = this.size();
			if(len > 0)
			{
				for(var i:uint = 0;i<len;i++)
				{
					result.push(this.props[this._keys[i]]);
				}
			}
			return result;
		}
		/**
		 *
		 * 返回整个键表，数组 
		 * @return 
		 * 
		 */		
		public function keys():Array
		{
			return this._keys;
		}
	}
}

