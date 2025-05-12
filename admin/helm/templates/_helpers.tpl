{{- define "admin-chart.name" -}}
{{- .Chart.Name -}}
{{- end }}

{{- define "admin-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
