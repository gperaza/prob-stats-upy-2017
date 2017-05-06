grades_ods_dir = grades
grades_html_dir = grades/html-export
grades_html = RoboA.html RoboB.html RoboC.html RoboD.html Embeb.html
grades_html := $(addprefix $(grades_html_dir)/,$(grades_html))

site_html_dir = pages-html
pages_html = syllabus.html homework.html
pages_html += lectures.html grades.html
pages_html := $(addprefix $(site_html_dir)/,$(pages_html))

site_org_dir= pages-org

export_script = ${site_org_dir}/export-html

all: index.html $(pages_html) #$(grades_html)

index.html: index.org $(export_script)
	$(export_script) $<

$(pages_html): $(site_html_dir)/%.html: $(site_org_dir)/%.org $(export_script)
	$(export_script) $<
	mv $(<:.org=.html) $(site_html_dir)

$(grades_html): $(grades_html_dir)/%.html: $(grades_ods_dir)/%.ods
	soffice --convert-to html $< --outdir $(grades_html_dir)

clean:
	rm index.html $(pages_html) $(grades_html) $(grades_html_dir)/*.png
