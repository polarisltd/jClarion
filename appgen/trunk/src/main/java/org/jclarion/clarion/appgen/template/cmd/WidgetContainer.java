package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;

public interface WidgetContainer {
	public abstract void addWidget(Widget w);
	public List<? extends Widget> getWidgets();
	public abstract String getLabel(ExecutionEnvironment environment);
}
