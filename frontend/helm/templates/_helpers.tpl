{{- define "frontend-chart.name" -}}
{{- .Chart.Name -}}
{{- end }}

{{- define "frontend-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
