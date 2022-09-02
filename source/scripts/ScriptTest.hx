package scripts;

class ScriptTest {
	static function main() {
		trace("Hello, world!");

		RunScript();
	}

	public static function RunScript() {
		var script = "

				var sample = 'My name is <strong>::name::</strong>, <em>::age::</em> years old';
				var user = {name: 'Mark', age: 30};
				var template = new haxe.Template(sample);
				var output = template.execute(user);
				trace(output);

				function main() {
					// var err = 0;;
					var angles = [Math.PI,Math.PI];  // cos(Math.PI) is -1
					sum = 0;
					for( a in angles )
						sum += Math.cos(a);
					return sum;
				}

				function main2() {
					return 'asd';
				}

				main();
			";
			var parser = new hscript.Parser();
			var program = parser.parseString(script);
			var interp = new hscript.Interp();
			interp.variables.set("Math", Math); // share the Math class
			// interp.variables.set("angles", [0,1,2,3]); // set the angles list
			trace( interp.execute(program) );
	}
}
