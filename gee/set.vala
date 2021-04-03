/* set.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
 */

/**
 * A collection without duplicate elements.
 */
[GenericAccessors]
public interface Gee.Set<G> : Collection<G> {

	/**
	 * The read-only view of this set.
	 */
	public abstract new Set<G> read_only_view { owned get; }

	/**
	 * Returns an immutable empty set.
	 *
	 * @return an immutable empty set
	 */
	public static Set<G> empty<G> () {
		return new HashSet<G> ().read_only_view;
	}

	public static void union<G>(Set<G> dest,
				    Set<G> set1,
				    Set<G> set2, ...)
	{
	    // This function needs to return a new set, but in this abstract
	    // class, we don't know what kind of set the user wants
	    // (TreeSet, HashSet, etc.). So, you have to provide an initialized
	    // destination object... and the first thing we do is clear it out.
	    
	    dest.clear();

	    // Add every element of set1
	    foreach (var s in set1)
	    {
		dest.add(s);
	    }

	    // Add every element of set2
	    foreach (var s in set2)
	    {
		dest.add(s);
	    }

	    // For every subsequent set given, add every element to the union
	    var l = va_list();
	    while (true)
	    {
		AbstractSet<G>? next_set = l.arg();
		if (next_set == null)
		{
		    break;  // end of the list
		}

		foreach(var s in next_set)
		{
		    dest.add(s);
		}
	    }
	}

	public static void intersection_two<G>(Set<G> dest,
					       Set<G> set1,
					       Set<G> set2)
	{
	    var smaller_set = set1;
	    var larger_set = set2;
	    if (set2.size < set1.size)
	    {
		smaller_set = set2;
		larger_set = set1;
	    }

	    foreach (var s in smaller_set)
	    {
		if (set1.contains(s) && set2.contains(s))
		    dest.add(s);
	    }
	}
	
	public static void intersection_all<G>(Set<G> dest,
					       Set<G> set1,
					       Set<G> set2, ...)
	{
	    var dummy = new HashSet<G>();
	    var isect2 = new HashSet<G>();
	    intersection_two(isect2, set1, set2);
	    
	    // Now isect2 is the intersection of the first two sets.
	    // If there are more sets, we intersect them in one at a time
	    var l = va_list();
	    while (true)
	    {	
		Set<G>? next_set = l.arg();
		if (next_set == null)
		{
		    break;  // end of the list
		}
		
		dummy.clear();
		intersection_two(dummy, next_set, isect2);
		isect2.clear();
		foreach (var s in dummy)
		{
		    isect2.add(s);
		}
	    }

	    // TODO: we're copying the copy we made at the end of the last
	    // iteration. Figure out how to not do that.
	    dest.clear();
	    foreach (var s in isect2)
	    {
		dest.add(s);
	    }
	}
}
