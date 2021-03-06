{% if err %}
<div style="margin-bottom: 20px">
{% for part in err %}
<p style="color: red">{{ part }}</p>
{% endfor %}
</div>
{% endif %}

<form method="post" action="{{ registry.uri }}mail/sort/?id={{ sort.0.sort_id }}">

<p><b>Сортировать по:</b></p>

{% for part in sort %}

{% if part.type == "from" %}
<p>Поле "От кого"</p>
<p>
	<input type="text" name="from" value="{{ part.val }}" style="width: 280px" />
</p>
{% endif %}

{% if part.type == "to" %}
<p>Поле "Кому"</p>
<p>
	<input type="text" name="to" value="{{ part.val }}" style="width: 280px" />
</p>
{% endif %}

{% if part.type == "subject" %}
<p>Поле "Тема" (содержит текст)</p>
<p>
	<input type="text" name="subject" value="{{ part.val }}" style="width: 280px" />
</p>
{% endif %}

{% endfor %}

<p><b>Действие:</b></p>

<p>
{% if not folders %}
	<a class="btn" href="{{ registry.uri }}mail/folder/">
	<i class="icon-folder-open"></i>
	Создать папку
	</a>
{% else %}
	<label class="radio inline">
	<input type="radio" class="mail_action" name="mail_action" {% if sort.0.action == "move" %}checked="checked"{% endif %} value="move" />
	Переместить в
	</label>
	<select name="folder">
		{% for part in folders %}
		<option value="{{ part.id }}" {% if sort.0.folder_id == part.id %}selected="selected"{% endif %}>{{ part.folder }}</option>
		{% endfor %}
	</select>
{% endif %}
</p>

<p>
<label class="radio inline">
	<input type="radio" class="mail_action" name="mail_action" {% if sort.0.action == "remove" %}checked="checked"{% endif %} value="remove" />
	удалить
</label>
</p>

<p style="margin-top: 10px">
<label class="radio inline">
	<input type="radio" class="mail_action" name="mail_action" {% if sort.0.action == "task" %}checked="checked"{% endif %} value="task" />
	создать задачу
</label>
</p>

<div id="addtask" style="display: none; padding-top: 20px">
{% include "mail/sorttask.tpl" %}
</div>

<p style="margin-top: 20px">
	<input type="submit" name="edit_sort" class="btn" value="Редактировать сортировку" />
</p>

</form>

<script type="text/javascript">
{% if sort.0.action == "task" %}$("#addtask").show();{% endif %}
$(".mail_action").change(function(){
	if ($(this).val() == "task") {
		$("#addtask").show();
	} else {
		$("#addtask").hide();
	}
});
</script>