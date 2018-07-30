import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';

import { ThfBreadcrumb } from '@totvs/thf-ui/components/thf-breadcrumb';
import { ThfDisclaimerGroup } from '@totvs/thf-ui/components/thf-disclaimer-group';
import { ThfDisclaimer } from '@totvs/thf-ui/components/thf-disclaimer/thf-disclaimer.interface';
import { ThfModalAction } from '@totvs/thf-ui/components/thf-modal';
import { ThfModalComponent } from '@totvs/thf-ui/components/thf-modal/thf-modal.component';
import { ThfPageAction, ThfPageFilter } from '@totvs/thf-ui/components/thf-page';
import { ThfTableColumn } from '@totvs/thf-ui/components/thf-table';
import { ThfI18nService } from '@totvs/thf-ui/services/thf-i18n';
import { ThfNotificationService } from '@totvs/thf-ui/services/thf-notification/thf-notification.service';

import { Subscription } from 'rxjs/Subscription';

import { TotvsResponse } from '../shared/interfaces/totvs-response.interface';

import { I{pascalCase} } from '../shared/model/{paramCase}.model';
import { {pascalCase}Service } from '../shared/services/{paramCase}.service';

@Component({
    selector: 'app-{paramCase}',
    templateUrl: './{paramCase}.list.component.html',
    styleUrls: ['./{paramCase}.list.component.css']
})
export class {pascalCase}ListComponent implements OnInit, OnDestroy {

    @ViewChild('modalDelete') modalDelete: ThfModalComponent;

    private itemsSubscription$: Subscription;
    private literalsSubscription$: Subscription;

    private disclaimers: Array<ThfDisclaimer> = [];

    cancelDeleteAction: ThfModalAction;
    confirmDeleteAction: ThfModalAction;

    pageActions: Array<ThfPageAction>;
    tableActions: Array<ThfPageAction>;

    breadcrumb: ThfBreadcrumb;
    disclaimerGroup: ThfDisclaimerGroup;
    filterSettings: ThfPageFilter;

    items: Array<I{pascalCase}>;
    columns: Array<ThfTableColumn>;

    hasNext: boolean;
    pageSize: number = 20;
    currentPage: number;

    isLoading = true;
    searchValue: string;

    literals: any = {};

    constructor(
        private service: {pascalCase}Service,
        private thfI18nService: ThfI18nService,
        private thfNotification: ThfNotificationService,
        private router: Router,
    ) {
        this.items = new Array<I{pascalCase}>();
        this.currentPage = 0;
    }

    ngOnInit(): void {
        this.literalsSubscription$ = this.thfI18nService
            .getLiterals({ context: '{camelCase}' })
            .subscribe(literals => {
                this.literals = literals;
                this.setupComponents();
            });
    }

    searchByName(filter = [{ property: 'name', value: this.searchValue }]): void {
        this.disclaimers = [...filter];
        this.disclaimerGroup.disclaimers = [...this.disclaimers];
    }

    search(loadMore = false): void {

        const disclaimer = this.disclaimers || [];

        if (loadMore === true) {
            this.currentPage = this.currentPage + 1;
        } else {
            this.items = [];
            this.currentPage = 1;
        }

        this.isLoading = true;
        this.itemsSubscription$ = this.service
            .query(disclaimer, this.currentPage, this.pageSize)
            .subscribe((response: TotvsResponse<I{pascalCase}>) => {
                this.items = this.items.concat(response.items);
                this.hasNext = response.hasNext;
                this.isLoading = false;
            });
    }

    private delete(): void {

        const selected = this.items.filter((item: any) => item.$selected);

        if (selected.length > 0) {
            selected.map(((item: I{pascalCase}) => {
                this.service.delete(item.id).subscribe(response => {
                    this.search();
                });
            }));
            this.thfNotification.success(this.literals['excluded{pascalCase}Message']);
        }
    }

    private edit(item: I{pascalCase}): void {
        this.router.navigate(['/{camelCase}/edit', item.id]);
    }

    private resetFilters(): void {
        this.searchValue = '';
    }

    private onChangeDisclaimer(disclaimers): void {
        this.disclaimers = disclaimers;
        if (this.disclaimers.length === 0) {
            this.resetFilters();
        }
        this.search();
    }

    private onConfirmDelete(): void {
        this.modalDelete.close();
        this.delete();
    }

    private setupComponents(): void {

        this.confirmDeleteAction = {
            action: () => this.onConfirmDelete(), label: this.literals['remove']
        };

        this.cancelDeleteAction = {
            action: () => this.modalDelete.close(), label: this.literals['return']
        };

        this.pageActions = [
            {
                label: this.literals['addNew{pascalCase}'],
                action: () => this.router.navigate(['{camelCase}/new']), icon: 'thf-icon-plus'
            },
            { label: this.literals['remove'], action: () => this.modalDelete.open() }
        ];

        this.tableActions = [
            { action: this.edit.bind(this), label: this.literals['edit'] },
        ];

        this.columns = [
            { column: 'id', label: this.literals['code'], type: 'string' },
            { column: 'name', label: this.literals['name'], type: 'link', action: (value, row) => this.edit(row) }
        ];

        this.breadcrumb = {
            items: [
                { label: this.literals['{camelCase}'], link: '/{camelCase}' }
            ]
        };

        this.disclaimerGroup = {
            title: this.literals['filters'],
            disclaimers: [],
            change: this.onChangeDisclaimer.bind(this)
        };

        this.filterSettings = {
            action: 'searchByName',
            ngModel: 'searchValue',
            placeholder: this.literals['search']
        };
    }

    ngOnDestroy(): void {
        this.itemsSubscription$.unsubscribe();
        this.literalsSubscription$.unsubscribe();
    }
}
