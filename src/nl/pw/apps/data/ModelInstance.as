package nl.pw.apps.data
{
	import feathers.data.ListCollection;
	/**
	 * ...
	 * @author Dave Woertman
	 */
	public final class ModelInstance
	{
		private static var _instance:ModelInstance;
		
		public var searchBooks:Array;
		
		public var searchOwnBooks:Array;
		public var selectedBook:BookVO;
		
		public function ModelInstance() 
		{
				if (_instance) {
						throw new Error("Singleton...Use getInstance instead");
				}
				_instance = this;
				
				this.selectedBook = new BookVO();
				
				this.searchOwnBooks = [
				{
					header: "0-9",
					children:
					[]
				},
				{
					header: "A",
					children:
					[]
				},
				{
					header: "B",
					children:
					[]
				},
				{
					header: "C",
					children:
					[]
				},
				{
					header: "D",
					children:
					[]
				},
				{
					header: "E",
					children:
					[]
				},
				{
					header: "F",
					children:
					[]
				},
				{
					header: "G",
					children:
					[]
				},
				{
					header: "H",
					children:
					[]
				},
				{
					header: "I",
					children:
					[]
				},
				{
					header: "J",
					children:
					[]
				},
				{
					header: "K",
					children:
					[]
				},
				{
					header: "L",
					children:
					[]
				},
				{
					header: "M",
					children:
					[]
				},
				{
					header: "N",
					children:
					[]
				},
				{
					header: "O",
					children:
					[]
				},
				{
					header: "P",
					children:
					[]
				},
				{
					header: "Q",
					children:
					[]
				},
				{
					header: "R",
					children:
					[]
				},
				{
					header: "S",
					children:
					[]
				},
				{
					header: "T",
					children:
					[]
				},
				{
					header: "U",
					children:
					[]
				},
				{
					header: "V",
					children:
					[]
				},
				{
					header: "W",
					children:
					[]
				},
				{
					header: "X",
					children:
					[]
				},
				{
					header: "Y",
					children:
					[]
				},
				{
					header: "Z",
					children:
					[]
				}
				];
				this.searchBooks = [
				{
					header: "0-9",
					children:
					[]
				},
				{
					header: "A",
					children:
					[]
				},
				{
					header: "B",
					children:
					[]
				},
				{
					header: "C",
					children:
					[]
				},
				{
					header: "D",
					children:
					[]
				},
				{
					header: "E",
					children:
					[]
				},
				{
					header: "F",
					children:
					[]
				},
				{
					header: "G",
					children:
					[]
				},
				{
					header: "H",
					children:
					[]
				},
				{
					header: "I",
					children:
					[]
				},
				{
					header: "J",
					children:
					[]
				},
				{
					header: "K",
					children:
					[]
				},
				{
					header: "L",
					children:
					[]
				},
				{
					header: "M",
					children:
					[]
				},
				{
					header: "N",
					children:
					[]
				},
				{
					header: "O",
					children:
					[]
				},
				{
					header: "P",
					children:
					[]
				},
				{
					header: "Q",
					children:
					[]
				},
				{
					header: "R",
					children:
					[]
				},
				{
					header: "S",
					children:
					[]
				},
				{
					header: "T",
					children:
					[]
				},
				{
					header: "U",
					children:
					[]
				},
				{
					header: "V",
					children:
					[]
				},
				{
					header: "W",
					children:
					[]
				},
				{
					header: "X",
					children:
					[]
				},
				{
					header: "Y",
					children:
					[]
				},
				{
					header: "Z",
					children:
					[]
				}
				];
		}
		public static function getInstance():ModelInstance {
			if (!_instance) {
					new ModelInstance();
			}
			return _instance;
		}
	}

}