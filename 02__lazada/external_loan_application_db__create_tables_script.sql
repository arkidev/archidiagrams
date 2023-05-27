create table borrower
(
    borrower_id    varchar(255) not null,
    address_id     int          null,
    mobile_number  varchar(12)  null,
    profile_id     varchar(255) null,
    full_name      varchar(255) not null,
    first_name     varchar(60)  not null,
    last_name      varchar(60)  not null,
    middle_name    varchar(60)  null,
    suffix         varchar(10)  null,
    nickname       varchar(30)  not null,
    gender         varchar(30)  not null,
    birth_date     date         not null,
    civil_status   varchar(10)  not null,
    nationality    varchar(20)  not null,
    id_number      varchar(30)  not null,
    id_type        varchar(255) not null,
    id_expiry_date date         not null,
    created_by     varchar(50)  not null,
    updated_by     varchar(50)  not null,
    date_created   datetime     not null,
    date_updated   datetime     null
);

alter table borrower
    add primary key (borrower_id);

create table borrower_address
(
    address_id           int auto_increment
        primary key,
    address_line1        varchar(255) not null,
    address_line2        varchar(255) null,
    street               varchar(100) not null,
    barangay             varchar(255) null,
    city_or_municipality varchar(100) not null,
    province             varchar(100) not null,
    region               varchar(30)  null,
    country              varchar(255) not null,
    postal_code          varchar(5)   null,
    created_by           varchar(50)  null,
    updated_by           varchar(50)  null,
    date_created         datetime     null,
    date_updated         datetime     null
);

alter table borrower
    add constraint borrower_borrower_address_address_id_fk
        foreign key (address_id) references borrower_address (address_id);

create table borrower_contact
(
    mobile_number          varchar(12)  not null,
    alternate_mobile_phone varchar(11)  null,
    landline_phone         varchar(11)  null,
    email                  varchar(100) not null,
    created_by             varchar(50)  null,
    updated_by             varchar(50)  null,
    date_created           datetime     not null,
    date_updated           datetime     not null
);

alter table borrower_contact
    add primary key (mobile_number);

alter table borrower
    add constraint borrower_borrower_contact_mobile_number_fk
        foreign key (mobile_number) references borrower_contact (mobile_number);

create table borrower_kyc_image
(
    kyc_image_id   int auto_increment
        primary key,
    application_id int          not null,
    image_type     varchar(100) null,
    download_url   text         null,
    created_by     varchar(50)  null,
    updated_by     varchar(50)  null,
    date_created   datetime     null,
    date_updated   datetime     null
);

create table borrower_profile
(
    profile_id                       varchar(255) not null,
    merchant_id                      varchar(50)  not null,
    borrower_type                    varchar(25)  not null,
    source_of_fund                   varchar(100) not null,
    nature_of_work                   varchar(255) not null,
    character_Reference_LastName     varchar(255) not null,
    character_Reference_FirstName    varchar(255) not null,
    character_Reference_MiddleName   varchar(255) null,
    character_Reference_MobileNumber varchar(12)  not null,
    character_Reference_Relationship varchar(255) null,
    created_by                       varchar(50)  not null,
    updated_by                       varchar(50)  not null,
    date_created                     datetime     null,
    date_updated                     datetime     not null
);

alter table borrower_profile
    add primary key (profile_id);

alter table borrower
    add constraint borrower_borrower_profile_profile_id_fk
        foreign key (profile_id) references borrower_profile (profile_id);

create table loan_application
(
    application_id                  int          not null,
    borrower_id                     varchar(255) null,
    product_id                      int          null,
    application_source              varchar(100) null,
    partner_identifier              varchar(255) null,
    status                          varchar(50)  null,
    status_reason                   varchar(255) null,
    data_Privacy_Agreement_DateTime datetime     not null,
    created_by                      varchar(50)  not null,
    updated_by                      varchar(50)  not null,
    date_created                    datetime     not null,
    date_updated                    datetime     not null
);

alter table loan_application
    add primary key (application_id);

alter table borrower_kyc_image
    add constraint borrower_kyc_image_loan_application_application_id_fk
        foreign key (application_id) references loan_application (application_id);

alter table loan_application
    add constraint loan_application_borrower_borrower_id_fk
        foreign key (borrower_id) references borrower (borrower_id);

create table product
(
    product_id        int          not null,
    parent_product_id int          null,
    name              varchar(50)  null,
    description       varchar(100) null,
    is_enabled        tinyint      null,
    gmt_create        datetime     null,
    gmt_modify        datetime     null
);

alter table product
    add primary key (product_id);

alter table loan_application
    add constraint loan_application_product_product_id_fk
        foreign key (product_id) references product (product_id);


