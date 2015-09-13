//Credits - Myself
proc/ConvertLists(var/list/z)
	var/tmp/list/Blah=new
	for(var/x in z)
		Blah.Add(params2list(x))
	return Blah
proc/ConvertLists2(var/list/z)
	return params2list(dd_file2params(z))


//Credits - Deadron
proc/dd_sortedtextlist(list/incoming, case_sensitive = 0)
	var/list/sorted_text = new()
	var/low_index
	var/high_index
	var/insert_index
	var/midway_calc
	var/current_index
	var/current_item
	var/list/list_bottom
	var/sort_result

	var/current_sort_text
	for (current_sort_text in incoming)
		low_index = 1
		high_index = sorted_text.len
		while (low_index <= high_index)
			midway_calc = (low_index + high_index) / 2
			current_index = round(midway_calc)
			if (midway_calc > current_index)
				current_index++
			current_item = sorted_text[current_index]

			if(case_sensitive)
				sort_result = sorttextEx(current_sort_text, current_item)
			else
				sort_result = sorttext(current_sort_text, current_item)

			switch(sort_result)
				if (1)
					high_index = current_index - 1	// current_sort_text < current_item
				if (-1)
					low_index = current_index + 1	// current_sort_text > current_item
				if (0)
					low_index = current_index		// current_sort_text == current_item
					break

		insert_index = low_index

		if (insert_index > sorted_text.len)
			sorted_text += current_sort_text
			continue

		list_bottom = sorted_text.Copy(insert_index)
		sorted_text.Cut(insert_index)
		sorted_text += current_sort_text
		sorted_text += list_bottom
	return sorted_text


proc/dd_sortedTextList(list/incoming,var/case_sensitive = 0)
	return dd_sortedtextlist(incoming, case_sensitive)




proc
	dd_file2list(file_path, separator = "\n")
		var/file
		if (isfile(file_path))
			file = file_path
		else
			file = file(file_path)
		return dd_text2list(file2text(file), separator)

	dd_text2list(text, separator)
		var/textlength      = lentext(text)
		var/separatorlength = lentext(separator)
		var/list/textList   = new /list()
		var/searchPosition  = 1
		var/findPosition    = 1
		var/buggyText
		while (1)
			findPosition = findtext(text, separator, searchPosition, 0)
			buggyText = copytext(text, searchPosition, findPosition)
			textList += "[buggyText]"

			searchPosition = findPosition + separatorlength
			if (findPosition == 0)
				return textList
			else
				if (searchPosition > textlength)
					textList += ""
					return textList
	dd_file2params(file_path, separator = "\n")
		var/file
		if (isfile(file_path))
			file = file_path
		else
			file = file(file_path)
		return dd_text2params(file2text(file), separator)
	dd_text2params(text, separator)
		var/textlength      = lentext(text)
		var/separatorlength = lentext(separator)
		var/textList
		var/searchPosition  = 1
		var/findPosition    = 1
		var/buggyText
		while (1)
			findPosition = findtext(text, separator, searchPosition, 0)
			buggyText = copytext(text, searchPosition, findPosition)
			textList += "[buggyText]&"
			searchPosition = findPosition + separatorlength
			if (findPosition == 0)
				return textList
			else
				if (searchPosition > textlength)
					textList += ""
					return textList
