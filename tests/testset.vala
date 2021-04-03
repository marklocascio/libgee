/* testset.vala
 *
 * Copyright (C) 2008  Jürg Billeter
 * Copyright (C) 2009  Didier Villevalois, Julien Peeters
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 * 	Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
 * 	Julien Peeters <contact@julienpeeters.fr>
 */

using GLib;
using Gee;

public abstract class SetTests : CollectionTests {

	protected SetTests (string name) {
		base (name);
		add_test ("[Set] duplicates are ignored", test_duplicates_are_ignored);
		add_test ("[Set] union of 2 sets of strings", test_union_two_sets_of_strings);
		add_test ("[Set] union of 5 sets of strings", test_union_five_sets_of_strings);
		add_test ("[Set] intersection of 2 sets of strings", test_isect_two_sets_of_strings);
		add_test ("[Set] intersection of 5 sets of strings", test_isect_five_sets_of_strings);
	}

	public virtual void test_duplicates_are_ignored () {
		var test_set = test_collection as Set<string>;

		// Check the test list is not null
		assert (test_set != null);

		assert (test_set.add ("one"));
		assert (test_set.contains ("one"));
		assert (test_set.size == 1);

		assert (! test_set.add ("one"));
		assert (test_set.contains ("one"));
		assert (test_set.size == 1);

		assert (test_set.remove ("one"));
		assert (! test_set.contains ("one"));
		assert (test_set.size == 0);

		assert (! test_set.remove ("one"));
		assert (! test_set.contains ("one"));
		assert (test_set.size == 0);
	}

	public virtual void test_union_two_sets_of_strings()
	{
	    // test_collection is defined in testcollection.vala like:
	    //      protected Collection<string> test_collection;
	    var test_set = test_collection as Set<string>;
	    
	    // Check the test list is not null and is empty
	    assert (test_set != null);
	    assert (test_set.size == 0);
	    
	    assert (test_set.add ("one"));
	    assert (test_set.add ("two"));
	    assert (! test_set.add ("two"));
	    assert (! test_set.add ("two"));
	    assert (test_set.add ("three"));
	    assert (test_set.add ("four"));
	    assert (test_set.size == 4);

	    Set<string> test_set2 = new TreeSet<string>();

	    assert (test_set2 != null);
	    assert (test_set2.size == 0);
	    
	    assert (test_set2.add ("five"));
	    assert (test_set2.add ("six"));
	    assert (! test_set2.add ("five"));
	    assert (! test_set2.add ("six"));
	    assert (test_set2.add ("three"));
	    assert (test_set2.add ("four"));
	    assert (test_set2.size == 4);

	    Set<string> union_set = new TreeSet<string>();
	    assert(union_set != null);
	    assert(union_set.size == 0);
	    
	    Set<string>.union(union_set, test_set, test_set2);
	    assert(union_set.size == 6);
	    assert(union_set.contains("one"));
	    assert(union_set.contains("two"));
	    assert(union_set.contains("three"));
	    assert(union_set.contains("four"));
	    assert(union_set.contains("five"));
	    assert(union_set.contains("six"));
	}

	public virtual void test_union_five_sets_of_strings()
	{
	    // test_collection is defined in testcollection.vala like:
	    //      protected Collection<string> test_collection;
	    var test_set = test_collection as Set<string>;
	    
	    // Check the test list is not null and is empty
	    assert (test_set.add ("one"));
	    assert (test_set.add ("two"));

	    Set<string> test_set2 = new TreeSet<string>();
	    assert (test_set2.add ("two"));
	    assert (test_set2.add ("three"));

	    Set<string> test_set3 = new TreeSet<string>();
	    assert (test_set3.add ("three"));
	    assert (test_set3.add ("four"));

	    Set<string> test_set4 = new TreeSet<string>();
	    assert (test_set4.add ("four"));
	    assert (test_set4.add ("five"));

	    Set<string> test_set5 = new TreeSet<string>();
	    assert (test_set5.add ("six"));
	    assert (test_set5.add ("seven"));
	    
	    Set<string> union_set = new TreeSet<string>();	    
	    Set<string>.union(union_set, test_set, test_set2, test_set3, test_set4, test_set5);
	    assert(union_set.size == 7);
	    assert(union_set.contains("one"));
	    assert(union_set.contains("two"));
	    assert(union_set.contains("three"));
	    assert(union_set.contains("four"));
	    assert(union_set.contains("five"));
	    assert(union_set.contains("six"));
	    assert(union_set.contains("seven"));

	    assert (test_set.size == 2);
	    assert (test_set.contains("one"));
	    assert (test_set.contains("two"));
	    
	    assert (test_set2.size == 2);
	    assert (test_set2.contains("two"));
	    assert (test_set2.contains("three"));

	    assert (test_set3.size == 2);
	    assert (test_set3.contains("three"));
	    assert (test_set3.contains("four"));

	    assert (test_set4.size == 2);
	    assert (test_set4.contains("four"));
	    assert (test_set4.contains("five"));

	    assert (test_set5.size == 2);
	    assert (test_set5.contains("six"));
	    assert (test_set5.contains("seven"));
	}

	public virtual void test_isect_two_sets_of_strings()
	{
	    // test_collection is defined in testcollection.vala like:
	    //      protected Collection<string> test_collection;
	    var test_set = test_collection as Set<string>;
	    
	    // Check the test list is not null and is empty
	    assert (test_set != null);
	    assert (test_set.size == 0);
	    
	    assert (test_set.add ("one"));
	    assert (test_set.add ("two"));
	    assert (! test_set.add ("two"));
	    assert (! test_set.add ("two"));
	    assert (test_set.add ("three"));
	    assert (test_set.add ("four"));
	    assert (test_set.size == 4);

	    Set<string> test_set2 = new TreeSet<string>();

	    assert (test_set2 != null);
	    assert (test_set2.size == 0);
	    
	    assert (test_set2.add ("five"));
	    assert (test_set2.add ("six"));
	    assert (! test_set2.add ("five"));
	    assert (! test_set2.add ("six"));
	    assert (test_set2.add ("three"));
	    assert (test_set2.add ("four"));
	    assert (test_set2.size == 4);

	    Set<string> isect_set = new TreeSet<string>();
	    assert(isect_set != null);
	    assert(isect_set.size == 0);
	    
	    Set<string>.intersection_two(isect_set, test_set, test_set2);
	    assert(isect_set.size == 2);
	    assert(! isect_set.contains("one"));
	    assert(! isect_set.contains("two"));
	    assert(isect_set.contains("three"));
	    assert(isect_set.contains("four"));
	    assert(! isect_set.contains("five"));
	    assert(! isect_set.contains("six"));
	}

	public virtual void test_isect_five_sets_of_strings()
	{
	    // test_collection is defined in testcollection.vala like:
	    //      protected Collection<string> test_collection;
	    var test_set = test_collection as Set<string>;
	    
	    // Check the test list is not null and is empty
	    assert (test_set != null);
	    assert (test_set.size == 0);
	    
	    assert (test_set.add ("one"));
	    assert (test_set.add ("two"));
	    assert (test_set.add ("three"));
	    assert (test_set.add ("four"));
	    assert (test_set.size == 4);

	    Set<string> test_set2 = new TreeSet<string>();
	    assert (test_set2.add ("three"));
	    assert (test_set2.add ("four"));
	    assert (test_set2.add ("five"));
	    assert (test_set2.add ("six"));
	    assert (test_set2.size == 4);

	    Set<string> test_set3 = new TreeSet<string>();
	    assert (test_set3.add ("three"));
	    assert (test_set3.add ("four"));
	    assert (test_set3.add ("seven"));
	    assert (test_set3.add ("eight"));
	    assert (test_set3.size == 4);

	    Set<string> test_set4 = new TreeSet<string>();
	    assert (test_set4.add ("nine"));
	    assert (test_set4.add ("three"));
	    assert (test_set4.add ("ten"));
	    assert (test_set4.add ("four"));
	    assert (test_set4.size == 4);

	    Set<string> test_set5 = new TreeSet<string>();
	    assert (test_set5.add ("one"));
	    assert (test_set5.add ("four"));
	    assert (test_set5.add ("three"));
	    assert (test_set5.add ("nine"));
	    assert (test_set5.size == 4);

	    Set<string> isect_set = new TreeSet<string>();
	    assert(isect_set != null);
	    assert(isect_set.size == 0);
	    
	    Set<string>.intersection_all(isect_set, test_set, test_set2, test_set3, test_set4, test_set5);
	    assert(isect_set.size == 2);
	    assert(! isect_set.contains("one"));
	    assert(! isect_set.contains("two"));
	    assert(isect_set.contains("three"));
	    assert(isect_set.contains("four"));
	    assert(! isect_set.contains("five"));
	    assert(! isect_set.contains("six"));
	    assert(! isect_set.contains("seven"));
	    assert(! isect_set.contains("eight"));
	    assert(! isect_set.contains("nine"));
	    assert(! isect_set.contains("ten"));
	}
}
