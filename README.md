# [TOTVS HTML Framework 2](https://thf.totvs.com.br/) Angular CRUD Template for VS CODE

This extension for Visual Studio Code adds the default CRUD template for TOTVS HTML Framework 2.

![Use Extension](https://github.com/totvs/thf-angular-crud-templates/raw/master/assets/images/totvs-thf2-crud.gif)

THF2 Suported version: `1.8.0`

## Usage

1. Follow the [THF2 Guide - Getting started](https://thf.totvs.com.br/guides/getting-started) to start a project;
2. On the `explorer/context` access the `THF2: CRUD Simple` option; or use the `command palette` to access the command `THF2: CRUD Simple`;
3. Inform the CRUD name, in `camelCase`, for the component;
* The plugin will generate a new module with the CRUD self-contained.
4. Register the module to the application module `src/app/app.module.ts`;
5. Register the i18n files to the [THF2 i18n Module](https://thf.totvs.com.br/documentation/thf-i18n):
    !(https://github.com/totvs/thf-angular-crud-templates/raw/master/assets/images/i18n.png)
6. Add the [dynamic route to module as lazy load](https://angular.io/guide/lazy-loading-ngmodules):
    !(https://github.com/totvs/thf-angular-crud-templates/raw/master/assets/images/route.png)

## Notes

The simple CRUD component structure will be like, starting at `./src/app/`:

```html
- shared
    - interfaces
        > totvs-response.interface.ts
    - literals
        - i18n
            > component-name-pt.ts
            > component-name-en.ts
            > component-name-es.ts
    - model
        > component-name.ts
    - services
        > component-name.service.ts
- component-name
    - edit
        > component-name.edit.component.css
        > component-name.edit.component.html
        > component-name.edit.component.ts
        > component-name.edit.component.spec.ts
    > component-name.list.component.css
    > component-name.list.component.html
    > component-name.list.component.ts
    > component-name.list.component.spec.ts
    > component-name-routing.module.ts
    > component-name.module.ts
```

## Release Notes

1.0.0
* Initial release with the CRUD simple template.