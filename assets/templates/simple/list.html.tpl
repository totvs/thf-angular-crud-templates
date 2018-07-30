<thf-page-list
    [t-title]="literals?.{camelCase}"
    [t-actions]="pageActions"
    [t-breadcrumb]="breadcrumb"
    [t-disclaimer-group]="disclaimerGroup"
    [t-filter]="filterSettings"
>
    <thf-table
        t-checkbox="true"
        t-hide-select-all="false"
        t-show-more-disabled="!hasNext"
        (t-show-more)="search(true)"
        [t-loading]="isLoading"
        [t-actions]="tableActions"
        [t-columns]="columns"
        [t-items]="items"
    >
    </thf-table>
</thf-page-list>

<thf-modal
    #modalDelete
    t-close
    t-size="sm"
    [t-title]="literals?.modalDeleteTitle"
    [t-primary-action]="confirmDeleteAction"
    [t-secondary-action]="cancelDeleteAction"
>
    <div class="thf-font-text-large thf-text-left">
        {{ literals?.modalDeleteMessage | thfI18n:[] }}
    </div>
</thf-modal>
