{{- define "backend-chart.name" -}}
{{- .Chart.Name -}}
{{- end }}

{{- define "backend-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
